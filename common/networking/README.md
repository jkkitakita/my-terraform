## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| gcp\_backend\_bucket |  | string | n/a | yes |
| gcp\_backend\_credentials | 基本的には、sampleのsample-dev-tfstateのbucketでbackendは固定 | string | n/a | yes |
| gcp\_backend\_project |  | string | n/a | yes |
| gcp\_backend\_region |  | string | n/a | yes |
| gcp\_credentials | provisioning先のプロジェクトのcredentials | string | n/a | yes |
| network\_name | The name of the network being created | map | `<map>` | no |
| subnetwork\_ip\_cidr\_range | The ip_cidr_range of the subnetwork being created | map | `<map>` | no |
| subnetwork\_name | The name of the network being created | map | `<map>` | no |
| subnetwork\_secondary\_ip\_cidr\_range\_for\_pod | The ip_cidr_range of the subnetwork being created | map | `<map>` | no |
| subnetwork\_secondary\_ip\_cidr\_range\_for\_svc | The ip_cidr_range of the subnetwork being created | map | `<map>` | no |
| subnetwork\_secondary\_ip\_range\_for\_pod\_name |  | string | `"subnet-2-pod"` | no |
| subnetwork\_secondary\_ip\_range\_for\_svc\_name |  | string | `"subnet-2-svc"` | no |
| vpn\_peer\_asn |  | string | `"7224"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ip\_cidr\_range | GCPのサブネットワークのIPアドレス範囲 |
| network\_name | GCPのネットワーク名 |
| subnetwork\_name | GCPのサブネットワーク名 |
| subnetwork\_secondary\_ip\_cidr\_range\_for\_pod | GCPのサブネットワークのセカンダリIP cidr range（for pod） |
| subnetwork\_secondary\_ip\_cidr\_range\_for\_svc | GCPのサブネットワークのセカンダリIP cidr range（for svc） |
| subnetwork\_secondary\_ip\_range\_for\_pod\_name | GCPのサブネットワークのセカンダリIPレンジの名前（for pod） |
| subnetwork\_secondary\_ip\_range\_for\_svc\_name | GCPのサブネットワークのセカンダリIPレンジの名前（for svc） |

