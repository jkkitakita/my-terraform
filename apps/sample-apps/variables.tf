locals {
  environment                                = "${element(split("-", terraform.workspace),1)}"
  project_id                                 = "${data.terraform_remote_state.project.project_id}"
  region                                     = "${data.terraform_remote_state.project.region}"
  network_name                               = "${data.terraform_remote_state.networking.network_name}"
  subnetwork_name                            = "${data.terraform_remote_state.networking.subnetwork_name}"
  subnetwork_secondary_ip_range_for_pod_name = "${data.terraform_remote_state.networking.subnetwork_secondary_ip_range_for_pod_name}"
  subnetwork_secondary_ip_range_for_svc_name = "${data.terraform_remote_state.networking.subnetwork_secondary_ip_range_for_svc_name}"
  subnetwork_secondary_ip_cidr_range_for_pod = "${data.terraform_remote_state.networking.subnetwork_secondary_ip_cidr_range_for_pod}"
  subnetwork_secondary_ip_cidr_range_for_svc = "${data.terraform_remote_state.networking.subnetwork_secondary_ip_cidr_range_for_svc}"
  service_name                               = "sample"
  map_var_fmt                                = "%s.%s"
}

# provisioning先のプロジェクトのcredentials
variable "gcp_credentials" {}

# 基本的には、sampleのsample-dev-tfstateのbucketでbackendは固定
variable "gcp_backend_credentials" {}

variable "gcp_backend_bucket" {}
variable "gcp_backend_project" {}
variable "gcp_backend_region" {}
