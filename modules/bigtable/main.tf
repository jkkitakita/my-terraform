resource "google_bigtable_instance" "instance" {
  name          = "${var.instance_name}"
  instance_type = "${var.instance_type}"

  cluster {
    cluster_id   = "${var.cluster_id}"
    zone         = "${var.zone}"
    num_nodes    = "${var.num_node}"
    storage_type = "${var.storage_type}"
  }
}

resource "google_bigtable_table" "table" {
  name          = "${var.table_name}"
  project       = "${var.project_id}"
  instance_name = "${google_bigtable_instance.instance.name}"
  split_keys    = "${var.table_split_keys}"

  column_family {
    family = "${var.table_column_family_1}"
  }

  column_family {
    family = "${var.table_column_family_2}"
  }

  column_family {
    family = "${var.table_column_family_3}"
  }

  column_family {
    family = "${var.table_column_family_4}"
  }
}
