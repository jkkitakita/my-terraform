output "environment" {
  description = "terraformを実行する対象環境"
  value       = "${local.environment}"
}

output "org_id" {
  description = "GCPの組織ID"
  value       = "${local.org_id}"
}

output "billing_account" {
  description = "GCPの請求アカウントID"
  value       = "${local.billing_account}"
}

output "project_id" {
  description = "GCPのプロジェクトID"
  value       = "${var.project_id[local.environment]}"
}

output "project_name" {
  description = "GCPのプロジェクト名"
  value       = "${var.project_name[local.environment]}"
}

output "region" {
  description = "リージョン"
  value       = "${var.region[local.environment]}"
}
