## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bigtable |  | map | `<map>` | no |
| cloudsql |  | map | `<map>` | no |
| gcp\_backend\_bucket |  | string | n/a | yes |
| gcp\_backend\_credentials | 基本的には、sampleのsample-dev-tfstateのbucketでbackendは固定 | string | n/a | yes |
| gcp\_backend\_project |  | string | n/a | yes |
| gcp\_backend\_region |  | string | n/a | yes |
| gcp\_credentials | provisioning先のプロジェクトのcredentials | string | n/a | yes |
| gke |  | map | `<map>` | no |
| memorystore | variables | map | `<map>` | no |
| pubsub |  | map | `<map>` | no |
| storage | variables | map | `<map>` | no |

