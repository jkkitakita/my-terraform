# variables
variable "memorystore" {
  type = "map"

  default = {
    tier.dev = "BASIC"
    tier.qa  = "STANDARD_HA"
    tier.prd = "STANDARD_HA"

    memory_size_gb.dev = 1
    memory_size_gb.qa  = 1
    memory_size_gb.prd = 20

    redis_version.dev = "REDIS_3_2"
    redis_version.qa  = "REDIS_3_2"
    redis_version.prd = "REDIS_3_2"

    reserved_ip_range.dev = "10.0.0.0/29"
    reserved_ip_range.qa  = "REDIS_3_2"
    reserved_ip_range.prd = "REDIS_3_2"
  }
}

# resource / module
module "memorystore" {
  source  = "terraform-google-modules/memorystore/google"
  version = "0.1.0"

  name    = "${local.environment}-${local.service_name}-ms01"
  project = "${local.project_id}"

  tier           = "${var.memorystore[format(local.map_var_fmt, "tier", local.environment)]}"
  memory_size_gb = "${var.memorystore[format(local.map_var_fmt, "memory_size_gb", local.environment)]}"
  location_id    = "${local.region}-b"

  // alternative_location_id = "${local.region}-b"

  authorized_network = "${local.network_name}"
  redis_version      = "${var.memorystore[format(local.map_var_fmt, "redis_version", local.environment)]}"
  display_name       = "${local.environment}-${local.service_name}-ms01"
  reserved_ip_range  = "${var.memorystore[format(local.map_var_fmt, "reserved_ip_range", local.environment)]}"
  labels = [{
    environment = "${local.environment}"
    service     = "${local.service_name}"
  }]
}
