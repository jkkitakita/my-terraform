## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| gcp\_backend\_bucket |  | string | n/a | yes |
| gcp\_backend\_credentials | 基本的には、sampleのsample-dev-tfstateのbucketでbackendは固定 | string | n/a | yes |
| gcp\_backend\_project |  | string | n/a | yes |
| gcp\_backend\_region |  | string | n/a | yes |
| gcp\_credentials | provisioning先のプロジェクトのcredentials | string | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | map | `<map>` | no |
| project\_name | The ID of the project where this VPC will be created | map | `<map>` | no |
| region |  | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| billing\_account | GCPの請求アカウントID |
| environment | terraformを実行する対象環境 |
| org\_id | GCPの組織ID |
| project\_id | GCPのプロジェクトID |
| project\_name | GCPのプロジェクト名 |
| region | リージョン |

