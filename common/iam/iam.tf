resource "google_project_iam_binding" "project-owner" {
  project = "${local.project_id}"
  role    = "roles/owner"

  members = [
    "user:jkkitakita@gmail.com",
  ]
}

resource "google_project_iam_binding" "cloudsql-admin" {
  project = "${local.project_id}"
  role    = "roles/cloudsql.admin"

  members = [
    "serviceAccount:gcloud-sql-users-create@${local.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "cloudsql-client" {
  project = "${local.project_id}"
  role    = "roles/cloudsql.client"

  members = [
    "serviceAccount:cloudsql@${local.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "pubsub-admin" {
  project = "${local.project_id}"
  role    = "roles/pubsub.admin"

  members = [
    "serviceAccount:pubsub-pub@${local.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "storage-admin" {
  project = "${local.project_id}"
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:circleci@${local.project_id}.iam.gserviceaccount.com",
  ]
}
