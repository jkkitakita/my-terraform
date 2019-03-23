resource "google_sql_database_instance" "master" {
  name             = "${var.instance_name}"
  database_version = "${var.database_version}"
  region           = "${var.region}"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    activation_policy = "ALWAYS"

    tier            = "${var.tier}"
    disk_autoresize = "true"
    disk_size       = "${var.disk_size}"
    disk_type       = "${var.disk_type}"

    maintenance_window = [{
      day          = "1"
      hour         = "20"
      update_track = "stable"
    }]

    user_labels = [{
      environment = "${var.environment}"
      service     = "${var.service}"
    }]
  }
}

resource "google_sql_user" "users" {
  name     = "${var.google_sql_user_name}"
  instance = "${google_sql_database_instance.master.name}"
  host     = "%"
}
