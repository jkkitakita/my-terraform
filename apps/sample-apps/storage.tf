# variables
variable "storage" {
  type = "map"

  default = {
    location.dev = "US"
    location.qa  = "US"
    location.prd = "ASIA"

    storage_class.dev = "STANDARD"
    storage_class.qa  = "STANDARD"
    storage_class.prd = "STANDARD"
  }
}

resource "google_storage_bucket" "sample-bucket" {
  name          = "sample-${local.environment}"
  project       = "${local.project_id}"
  location      = "${var.storage[format(local.map_var_fmt, "location", local.environment)]}"
  storage_class = "${var.storage[format(local.map_var_fmt, "storage_class", local.environment)]}"

  labels = [{
    environment = "${local.environment}"
    service     = "${local.service_name}"
  }]
}
