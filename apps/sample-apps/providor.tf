terraform {
  required_version = ">= 0.11, < 0.12"
  backend          "gcs"            {}
}

provider "google" {
  version = "~> 2.0.0"

  credentials = "${file(var.gcp_credentials)}"
  project     = "${local.project_id}"
  region      = "${local.region}"

  // NOTE: terraform import時は直がきしないとダメ。
  // credentials = "~/.config/gcloud/sample.json"
  // project     = "sample"
  // region      = "us-west1"
}
