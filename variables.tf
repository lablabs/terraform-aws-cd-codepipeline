variable "name" {
  type = string
}

variable "codebuild_build_timeout" {
  type    = string
  default = "120"
}

variable "codebuild_source_version" {
  type    = string
  default = "refs/heads/master"
}

variable "tags" {
  type    = map(string)
  default = {}
}

# build variables

variable "codebuild_compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}
variable "codebuild_image_url" {
  type = string
}
variable "codebuild_image_tag" {
  type    = string
  default = "latest"
}
variable "codebuild_image_repository_arn" {
  type = string
}
variable "codebuild_var_eks_cluster_id" {
  type = string
}
variable "codebuild_var_environment" {
  type = string
}
variable "codebuild_var_k8s_namespace" {
  type = string
}
variable "codebuild_var_stack_name" {
  type = string
}
variable "codebuild_var_chart_name" {
  type = string
}
variable "codebuild_var_ssm_path_access_key" {
  type = string
}
variable "codebuild_var_ssm_path_secret_key" {
  type = string
}
variable "codebuild_var_ssm_path_basicauth_user" {
  type = string
}
variable "codebuild_var_ssm_path_basicauth_pass" {
  type = string
}

# vpc

variable "codebuild_vpc_id" {
  type = string
}
variable "codebuild_subnets" {
  type = list(string)
}
variable "codebuild_security_group_ids" {
  type = list(string)
}

# codecommit

variable "codecommit_charts_repo_name" {
  type = string
}
variable "codecommit_scripts_repo_name" {
  type = string
}
variable "codecommit_main_repo_name" {
  type = string
}

# codepipeline

variable "codepipeline_soapui_run" {
  default = false
}
