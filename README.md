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
| terraform | ~> 0.12.6 |
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| codebuild\_image\_repository\_arn | n/a | `any` | n/a | yes |
| codebuild\_image\_url | n/a | `any` | n/a | yes |
| codebuild\_security\_group\_ids | n/a | `any` | n/a | yes |
| codebuild\_subnets | n/a | `any` | n/a | yes |
| codebuild\_var\_chart\_name | n/a | `any` | n/a | yes |
| codebuild\_var\_eks\_cluster\_id | n/a | `any` | n/a | yes |
| codebuild\_var\_environment | n/a | `any` | n/a | yes |
| codebuild\_var\_k8s\_namespace | n/a | `any` | n/a | yes |
| codebuild\_var\_ssm\_path\_access\_key | n/a | `any` | n/a | yes |
| codebuild\_var\_ssm\_path\_basicauth\_pass | n/a | `any` | n/a | yes |
| codebuild\_var\_ssm\_path\_basicauth\_user | n/a | `any` | n/a | yes |
| codebuild\_var\_ssm\_path\_secret\_key | n/a | `any` | n/a | yes |
| codebuild\_var\_stack\_name | n/a | `any` | n/a | yes |
| codebuild\_vpc\_id | n/a | `any` | n/a | yes |
| codecommit\_charts\_repo\_name | n/a | `any` | n/a | yes |
| codecommit\_main\_repo\_name | n/a | `any` | n/a | yes |
| codecommit\_scripts\_repo\_name | n/a | `any` | n/a | yes |
| name | n/a | `any` | n/a | yes |
| ssm\_kms\_key\_arn | n/a | `any` | n/a | yes |
| codebuild\_build\_timeout | n/a | `string` | `"120"` | no |
| codebuild\_compute\_type | n/a | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| codebuild\_image\_tag | n/a | `string` | `"latest"` | no |
| codebuild\_source\_version | n/a | `string` | `"refs/heads/master"` | no |
| codepipeline\_soapui\_run | n/a | `bool` | `false` | no |
| tags | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| pipeline\_iam\_role\_arn | n/a |

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
