variable "cloudsql" {
  type = "map"

  default = {
    database_version.dev = "MYSQL_5_7"
    database_version.qa  = "MYSQL_5_7"
    database_version.prd = "MYSQL_5_7"

    tier.dev = "db-f1-micro"
    tier.qa  = "db-f1-micro"
    tier.prd = "db-f1-micro"

    disk_size.dev = "100"
    disk_size.qa  = "100"
    disk_size.prd = "300"

    disk_type.dev = "PD_SSD"
    disk_type.qa  = "PD_SSD"
    disk_type.prd = "PD_SSD"

    google_sql_user_name.dev = "admin"
    google_sql_user_name.qa  = "admin"
    google_sql_user_name.prd = "admin"
  }
}

module "cloudsql" {
  source = "../../modules/cloudsql"

  # CloudSQL instnace
  instance_name    = "${local.environment}-${local.service_name}"
  database_version = "${var.cloudsql[format(local.map_var_fmt, "database_version", local.environment)]}"
  region           = "${local.region}"

  ## settings variables
  tier      = "${var.cloudsql[format(local.map_var_fmt, "tier", local.environment)]}"
  disk_size = "${var.cloudsql[format(local.map_var_fmt, "disk_size", local.environment)]}"
  disk_type = "${var.cloudsql[format(local.map_var_fmt, "disk_type", local.environment)]}"

  ## user_labels
  environment = "${local.environment}"
  service     = "${local.service_name}"

  # CloudSQL user
  google_sql_user_name = "${var.cloudsql[format(local.map_var_fmt, "google_sql_user_name", local.environment)]}"
}
