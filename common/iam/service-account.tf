resource "google_service_account" "terraform" {
  account_id   = "terraform"
  display_name = "terraform"
}

resource "google_service_account" "pubsub" {
  account_id   = "pubsub-pub"
  display_name = "pubsub.pub"
}

resource "google_service_account" "cloudsql" {
  account_id   = "cloudsql"
  display_name = "cloudsql"
}

resource "google_service_account" "gcloud-sql-users-create" {
  account_id   = "gcloud-sql-users-create"
  display_name = "gcloud.sql.users.create"
}

resource "google_service_account" "circleci" {
  account_id   = "circleci"
  display_name = "circleci"
}

resource "google_service_account" "bigquery" {
  account_id   = "bigquery"
  display_name = "bigquery"
}
