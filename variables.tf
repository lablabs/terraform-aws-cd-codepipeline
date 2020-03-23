variable "name" {}

variable "codebuild_build_timeout" {
  default = "120"
}

variable "codebuild_source_version" {
  default = "refs/heads/master"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ssm_kms_key_arn" {}

# build variables
variable "codebuild_var_eks_cluster_id" {}
variable "codebuild_var_environment" {}
variable "codebuild_var_k8s_namespace" {}
variable "codebuild_var_stack_name" {}
variable "codebuild_var_chart_name" {}
variable "codebuild_var_ssm_path_access_key" {}
variable "codebuild_var_ssm_path_secret_key" {}

# vpc
variable "codebuild_vpc_id" {}
variable "codebuild_subnets" {}
variable "codebuild_security_group_ids" {}

# codecommit
variable "codecommit_charts_repo_name" {}
variable "codecommit_scripts_repo_name" {}
variable "codecommit_main_repo_name" {}