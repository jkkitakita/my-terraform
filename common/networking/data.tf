data "terraform_remote_state" "project" {
  backend   = "gcs"
  workspace = "project-${local.environment}"

  config {
    bucket      = "${var.gcp_backend_bucket}"
    prefix      = "common"
    project     = "${var.gcp_backend_bucket}"
    region      = "${var.gcp_backend_region}"
    credentials = "${file(var.gcp_backend_credentials)}"
  }
}
