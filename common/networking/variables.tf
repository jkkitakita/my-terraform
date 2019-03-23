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

variable "network_name" {
  description = "The name of the network being created"
  type        = "map"

  default = {
    dev = "sample-dev"
    qa  = "sample-qa"
    prd = "sample-prd"
  }
}

variable "subnetwork_name" {
  description = "The name of the network being created"
  type        = "map"

  default = {
    dev = "sample-dev-default"
    qa  = "sample-qa"
    prd = "sample-prd"
  }
}

variable "subnetwork_ip_cidr_range" {
  description = "The ip_cidr_range of the subnetwork being created"
  type        = "map"

  default = {
    dev = "10.124.0.0/20"
    qa  = "10.138.0.0/20"
    prd = "10.146.0.0/20"
  }
}

variable "subnetwork_secondary_ip_range_for_pod_name" {
  default = "subnet-2-pod"
}

variable "subnetwork_secondary_ip_range_for_svc_name" {
  default = "subnet-2-svc"
}

variable "subnetwork_secondary_ip_cidr_range_for_pod" {
  description = "The ip_cidr_range of the subnetwork being created"
  type        = "map"

  default = {
    dev = "10.124.128.0/19"
    qa  = "10.138.128.0/19"
    prd = "10.146.128.0/19"
  }
}

variable "subnetwork_secondary_ip_cidr_range_for_svc" {
  description = "The ip_cidr_range of the subnetwork being created"
  type        = "map"

  default = {
    dev = "10.124.160.0/22"
    qa  = "10.138.160.0/22"
    prd = "10.146.160.0/22"
  }
}

variable "vpn_peer_asn" {
  default = 7224
}
