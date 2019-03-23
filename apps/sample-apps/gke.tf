variable "gke" {
  type = "map"

  default = {
    initial_node_count.dev = 0
    initial_node_count.qa  = 1
    initial_node_count.prd = 1

    machine_type.dev = "n1-standard-2"
    machine_type.qa  = "n1-standard-2"
    machine_type.prd = "n1-highmem-4"

    node_count.dev = 1
    node_count.qa  = 1
    node_count.prd = 1

    min_count.dev = 1
    min_count.qa  = 1
    min_count.prd = 1

    max_count.dev = 1
    max_count.qa  = 1
    max_count.prd = 1

    disk_size_gb.dev = 30
    disk_size_gb.qa  = 30
    disk_size_gb.prd = 100

    disk_type.dev = "pd-standard"
    disk_type.qa  = "pd-standard"
    disk_type.prd = "pd-standard"

    image_type.dev = "COS"
    image_type.qa  = "COS"
    image_type.prd = "COS"

    service_account.dev = "project-service-account@.iam.gserviceaccount.com"
    service_account.tg  = "project-service-account@.iam.gserviceaccount.com"
    service_account.prd = "project-service-account@.iam.gserviceaccount.com"
  }
}

resource "google_container_node_pool" "sample-cluster-node-pool" {
  name       = "${local.environment}-${local.service_name}-node-pool"
  project    = "${local.project_id}"
  zone       = "${local.region}-a"
  node_count = "${var.gke[format(local.map_var_fmt, "node_count", local.environment)]}"
  cluster    = "${google_container_cluster.sample-cluster.name}"

  node_config {
    machine_type = "${var.gke[format(local.map_var_fmt, "machine_type", local.environment)]}"
    disk_size_gb = "${var.gke[format(local.map_var_fmt, "disk_size_gb", local.environment)]}"
    disk_type    = "${var.gke[format(local.map_var_fmt, "disk_type", local.environment)]}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]

    labels = [{
      environment = "${local.environment}"
      service     = "${local.service_name}"
    }]
  }

  autoscaling {
    min_node_count = "${var.gke[format(local.map_var_fmt, "min_count", local.environment)]}"
    max_node_count = "${var.gke[format(local.map_var_fmt, "max_count", local.environment)]}"
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

resource "google_container_cluster" "sample-cluster" {
  name               = "${local.environment}-${local.service_name}-cluster01"
  project            = "${local.project_id}"
  zone               = "${local.region}-a"
  network            = "${local.network_name}"
  subnetwork         = "${local.subnetwork_name}"
  initial_node_count = "${var.gke[format(local.map_var_fmt, "initial_node_count", local.environment)]}"

  # Setting an empty username and password explicitly disables basic auth
  master_auth {
    username = "admin"
    password = ""
  }

  resource_labels = [{
    environment = "${local.environment}"
    service     = "${local.service_name}"
  }]

  timeouts {
    create = "30m"
    update = "40m"
  }

  ip_allocation_policy = [{
    cluster_secondary_range_name  = "${local.subnetwork_secondary_ip_range_for_pod_name}"
    services_secondary_range_name = "${local.subnetwork_secondary_ip_range_for_svc_name}"
  }]

  lifecycle {
    ignore_changes = ["master_auth"]
  }
}
