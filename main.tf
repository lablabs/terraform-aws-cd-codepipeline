data "aws_codecommit_repository" "charts" {
  repository_name = var.codecommit_charts_repo_name
}

data "aws_codecommit_repository" "scripts" {
  repository_name = var.codecommit_scripts_repo_name
}

data "aws_codecommit_repository" "main" {
  repository_name = var.codecommit_main_repo_name
}

# Codebuild
resource "aws_codebuild_project" "default" {
  name           = var.name
  build_timeout  = var.codebuild_build_timeout
  service_role   = aws_iam_role.pipeline.arn
  source_version = var.codebuild_source_version

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.main.clone_url_http
    git_clone_depth = 1
  }

  secondary_sources {
    type              = "CODECOMMIT"
    location          = data.aws_codecommit_repository.charts.clone_url_http
    source_identifier = "charts"
    git_clone_depth   = 1
  }

  secondary_sources {
    type              = "CODECOMMIT"
    location          = data.aws_codecommit_repository.scripts.clone_url_http
    source_identifier = "scripts"
    git_clone_depth   = 1
  }

  environment {
    compute_type                = var.codebuild_compute_type
    image                       = "${var.codebuild_image_url}:${var.codebuild_image_tag}"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"

    environment_variable {
      name  = "HELM_DIFF"
      value = "true"
    }

    environment_variable {
      name  = "EKS_CLUSTER_ID"
      value = var.codebuild_var_eks_cluster_id
    }

    environment_variable {
      name  = "ENVIRONMENT"
      value = var.codebuild_var_environment
    }

    environment_variable {
      name  = "K8S_NAMESPACE"
      value = var.codebuild_var_k8s_namespace
    }

    environment_variable {
      name  = "NAME"
      value = var.codebuild_var_stack_name
    }

    environment_variable {
      name  = "HELM_CHART_NAME"
      value = var.codebuild_var_chart_name
    }

    environment_variable {
      name  = "AWS_ACCESS_KEY_ID"
      value = var.codebuild_var_ssm_path_access_key
      type  = "PARAMETER_STORE"
    }

    environment_variable {
      name  = "AWS_SECRET_ACCESS_KEY"
      value = var.codebuild_var_ssm_path_secret_key
      type  = "PARAMETER_STORE"
    }

    environment_variable {
      name  = "BASICAUTH_USER"
      value = var.codebuild_var_ssm_path_basicauth_user
      type  = "PARAMETER_STORE"
    }

    environment_variable {
      name  = "BASICAUTH_PASS"
      value = var.codebuild_var_ssm_path_basicauth_pass
      type  = "PARAMETER_STORE"
    }

  }

  vpc_config {
    vpc_id             = var.codebuild_vpc_id
    subnets            = var.codebuild_subnets
    security_group_ids = var.codebuild_security_group_ids
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/cicd/${var.name}"
    }
  }

  tags = var.tags

  depends_on = [
    aws_iam_policy.pipeline,
    aws_iam_role.pipeline,
    aws_iam_role_policy_attachment.pipeline
  ]
}

# CodePipeline
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.name}-codepipeline"
  acl    = "private"
}

resource "aws_codepipeline" "default" {
  name     = var.name
  role_arn = aws_iam_role.pipeline.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = var.codecommit_main_repo_name
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "SoapUI"

    action {
      name            = "SoapUI"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["SourceArtifact"]

      configuration = {
        ProjectName          = var.name
        EnvironmentVariables = "[{\"name\":\"SOAPUI_RUN\",\"value\":\"${var.codepipeline_soapui_run}\",\"type\":\"PLAINTEXT\"}]"
      }
    }
  }

  stage {
    name = "Diff"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["SourceArtifact"]

      configuration = {
        ProjectName = var.name
      }
    }
  }

  stage {
    name = "Approval"

    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["SourceArtifact"]

      configuration = {
        ProjectName          = var.name
        EnvironmentVariables = "[{\"name\":\"HELM_DIFF\",\"value\":\"false\",\"type\":\"PLAINTEXT\"}]"
      }
    }
  }

  tags = var.tags
}

# iam
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "pipeline" {
  statement {
    sid = "CloudWatch"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/cicd/${var.name}",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/cicd/${var.name}:*"
    ]

    effect = "Allow"
  }

  statement {
    sid = "EC2"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
      "ec2:CreateNetworkInterfacePermission"
    ]

    resources = [
      "*"
    ]

    effect = "Allow"
  }

  statement {
    sid = "CodeCommit"

    actions = [
      "codecommit:*"
    ]

    resources = [
      data.aws_codecommit_repository.charts.arn,
      data.aws_codecommit_repository.scripts.arn,
      data.aws_codecommit_repository.main.arn
    ]

    effect = "Allow"
  }

  statement {
    sid = "KMS"

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey"
    ]

    resources = [
      var.ssm_kms_key_arn
    ]

    effect = "Allow"
  }

  statement {
    sid = "Secrets"

    actions = [
      "ssm:GetParameters"
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${var.codebuild_var_ssm_path_access_key}",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${var.codebuild_var_ssm_path_secret_key}",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${var.codebuild_var_ssm_path_basicauth_user}",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${var.codebuild_var_ssm_path_basicauth_pass}"
    ]

    effect = "Allow"
  }

  statement {
    sid = "S3"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.codepipeline_bucket.arn}",
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]

    effect = "Allow"
  }

  statement {
    sid = "CodeBuild"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]

    resources = [
      "*"
    ]

    effect = "Allow"
  }

  statement {
    sid = "ECRGetToken"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }

  statement {
    sid = "ECRPullImage"

    actions = [
      "ecr:*"
    ]

    resources = [
      var.codebuild_image_repository_arn
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "pipeline" {
  name        = "${var.name}-pipeline"
  path        = "/"
  description = "Policy for pipeline service"

  policy = data.aws_iam_policy_document.pipeline.json
}

data "aws_iam_policy_document" "pipeline_assume" {

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com",
        "codepipeline.amazonaws.com"
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "pipeline" {
  name               = "${var.name}-pipeline"
  assume_role_policy = data.aws_iam_policy_document.pipeline_assume.json
}

resource "aws_iam_role_policy_attachment" "pipeline" {
  role       = aws_iam_role.pipeline.name
  policy_arn = aws_iam_policy.pipeline.arn
}