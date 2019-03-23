variable "bigtable" {
  type = "map"

  default = {
    instance_type.dev = "PRODUCTION"
    instance_type.qa  = "PRODUCTION"
    instance_type.prd = "PRODUCTION"

    cluster_num_node.dev = 3
    cluster_num_node.qa  = 3
    cluster_num_node.prd = 3

    cluster_storage_type.dev = "HDD"
    cluster_storage_type.qa  = "SSD"
    cluster_storage_type.prd = "SSD"
  }
}

# NOTE: split keysは不要
// variable "table_split_keys" {
//   type = "map"
//   default = {
//     dev  = ["a", "b", "c"]
//     qa = ["a", "b", "c"]
//     prd = ["a", "b", "c"]
//   }
// }

module "bigtable" {
  source     = "../../modules/bigtable"
  project_id = "${local.project_id}"

  instance_name = "${local.environment}-${local.service_name}-cbt"
  instance_type = "${var.bigtable[format(local.map_var_fmt, "instance_type", local.environment)]}"

  cluster_id   = "${local.environment}-${local.service_name}-cbt-cluster"
  zone         = "${local.region}-b"
  num_node     = "${var.bigtable[format(local.map_var_fmt, "cluster_num_node", local.environment)]}"
  storage_type = "${var.bigtable[format(local.map_var_fmt, "cluster_storage_type", local.environment)]}"

  table_name = "${local.environment}-${local.service_name}-table"

  // table_split_keys    = "${var.table_split_keys[local.environment]}"
  table_column_family_1 = "trackingF"
  table_column_family_2 = "sessionF"
  table_column_family_3 = "physicalF"
  table_column_family_4 = "othersF"
}
