# AWS CD CodePipeline Terraform module

[![Labyrinth Labs logo](ll-logo.png)](https://www.lablabs.io)

We help companies build, run, deploy and scale software and infrastructure by embracing the right technologies and principles. Check out our website at https://lablabs.io/

---

![Terraform validation](https://github.com/lablabs/terraform-aws-cd-codepipeline/workflows/Terraform%20validation/badge.svg?branch=master)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## Description

A terraform module to create AWS CodeBuild and CodePipeline resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.codepipeline_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_codecommit_repository.charts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codecommit_repository) | data source |
| [aws_codecommit_repository.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codecommit_repository) | data source |
| [aws_codecommit_repository.scripts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codecommit_repository) | data source |
| [aws_iam_policy_document.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codebuild_image_repository_arn"></a> [codebuild\_image\_repository\_arn](#input\_codebuild\_image\_repository\_arn) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_image_url"></a> [codebuild\_image\_url](#input\_codebuild\_image\_url) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_security_group_ids"></a> [codebuild\_security\_group\_ids](#input\_codebuild\_security\_group\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_codebuild_subnets"></a> [codebuild\_subnets](#input\_codebuild\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_codebuild_var_chart_name"></a> [codebuild\_var\_chart\_name](#input\_codebuild\_var\_chart\_name) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_eks_cluster_id"></a> [codebuild\_var\_eks\_cluster\_id](#input\_codebuild\_var\_eks\_cluster\_id) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_environment"></a> [codebuild\_var\_environment](#input\_codebuild\_var\_environment) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_k8s_namespace"></a> [codebuild\_var\_k8s\_namespace](#input\_codebuild\_var\_k8s\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_ssm_path_access_key"></a> [codebuild\_var\_ssm\_path\_access\_key](#input\_codebuild\_var\_ssm\_path\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_ssm_path_basicauth_pass"></a> [codebuild\_var\_ssm\_path\_basicauth\_pass](#input\_codebuild\_var\_ssm\_path\_basicauth\_pass) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_ssm_path_basicauth_user"></a> [codebuild\_var\_ssm\_path\_basicauth\_user](#input\_codebuild\_var\_ssm\_path\_basicauth\_user) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_ssm_path_secret_key"></a> [codebuild\_var\_ssm\_path\_secret\_key](#input\_codebuild\_var\_ssm\_path\_secret\_key) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_var_stack_name"></a> [codebuild\_var\_stack\_name](#input\_codebuild\_var\_stack\_name) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_vpc_id"></a> [codebuild\_vpc\_id](#input\_codebuild\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_codecommit_charts_repo_name"></a> [codecommit\_charts\_repo\_name](#input\_codecommit\_charts\_repo\_name) | n/a | `string` | n/a | yes |
| <a name="input_codecommit_main_repo_name"></a> [codecommit\_main\_repo\_name](#input\_codecommit\_main\_repo\_name) | n/a | `string` | n/a | yes |
| <a name="input_codecommit_scripts_repo_name"></a> [codecommit\_scripts\_repo\_name](#input\_codecommit\_scripts\_repo\_name) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_build_timeout"></a> [codebuild\_build\_timeout](#input\_codebuild\_build\_timeout) | n/a | `string` | `"120"` | no |
| <a name="input_codebuild_compute_type"></a> [codebuild\_compute\_type](#input\_codebuild\_compute\_type) | n/a | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_codebuild_image_tag"></a> [codebuild\_image\_tag](#input\_codebuild\_image\_tag) | n/a | `string` | `"latest"` | no |
| <a name="input_codebuild_source_version"></a> [codebuild\_source\_version](#input\_codebuild\_source\_version) | n/a | `string` | `"refs/heads/master"` | no |
| <a name="input_codepipeline_soapui_run"></a> [codepipeline\_soapui\_run](#input\_codepipeline\_soapui\_run) | n/a | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pipeline_iam_role_arn"></a> [pipeline\_iam\_role\_arn](#output\_pipeline\_iam\_role\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing and reporting issues

Feel free to create an issue in this repository if you have questions, suggestions or feature requests.

### Validation, linters and pull-requests

We want to provide high quality code and modules. For this reason we are using
several [pre-commit hooks](.pre-commit-config.yaml) and
[GitHub Actions workflow](.github/workflows/main.yml). A pull-request to the
master branch will trigger these validations and lints automatically. Please
check your code before you will create pull-requests. See
[pre-commit documentation](https://pre-commit.com/) and
[GitHub Actions documentation](https://docs.github.com/en/actions) for further
details.


## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
