locals {
  environment     = "${element(split("-", terraform.workspace),1)}"
  org_id          = "894457886582"
  billing_account = "01BC23-081567-DBEB91"
}

# provisioning先のプロジェクトのcredentials
variable "gcp_credentials" {}

# 基本的には、sampleのsample-dev-tfstateのbucketでbackendは固定
variable "gcp_backend_credentials" {}

variable "gcp_backend_bucket" {}
variable "gcp_backend_project" {}
variable "gcp_backend_region" {}

variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = "map"

  default = {
    dev = "sample"
    qa  = "sample"
    prd = "sample-prd"
  }
}

variable "project_name" {
  description = "The ID of the project where this VPC will be created"
  type        = "map"

  default = {
    dev = "sample-dev"
    qa  = "sample-dev"
    prd = "sample-prd"
  }
}

variable "region" {
  type = "map"

  default = {
    dev = "us-west1"
    qa  = "us-west1"
    prd = "asia-northeast1"
  }
}
