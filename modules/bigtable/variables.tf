variable "project_id" {}

variable "instance_name" {}

variable "instance_type" {}

variable "cluster_id" {}

variable "zone" {}

variable "num_node" {}

variable "storage_type" {}

variable "table_name" {}

variable "table_split_keys" {
  type        = "list"
  description = "The list of the bigtable split keys"
  default     = []
}

variable "table_column_family_1" {
  type = "string"
}

variable "table_column_family_2" {
  type = "string"
}

variable "table_column_family_3" {
  type = "string"
}

variable "table_column_family_4" {
  type = "string"
}
