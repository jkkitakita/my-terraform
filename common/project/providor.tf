terraform {
  required_version = ">= 0.11, < 0.12"
  backend          "gcs"            {}
}

provider "google" {
  version = "~> 2.0.0"

  credentials = "${file(var.gcp_credentials)}"
  project     = "${var.project_id[local.environment]}"
  region      = "${var.region[local.environment]}"
}
