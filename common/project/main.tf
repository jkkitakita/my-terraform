resource "google_project" "this_project" {
  name            = "${var.project_name[local.environment]}"
  project_id      = "${var.project_id[local.environment]}"
  org_id          = "${local.org_id}"
  billing_account = "${local.billing_account}"
}
