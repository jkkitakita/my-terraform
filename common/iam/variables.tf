locals {
  environment = "${element(split("-", terraform.workspace),1)}"
  project_id  = "${data.terraform_remote_state.project.project_id}"
  region      = "${data.terraform_remote_state.project.region}"
}

# provisioning先のプロジェクトのcredentials
variable "gcp_credentials" {}

# 基本的には、sampleのsample-dev-tfstateのbucketでbackendは固定
variable "gcp_backend_credentials" {}

variable "gcp_backend_bucket" {}
variable "gcp_backend_project" {}
variable "gcp_backend_region" {}
