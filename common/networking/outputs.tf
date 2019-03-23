output "network_name" {
  description = "GCPのネットワーク名"
  value       = "${google_compute_network.custom-network.name}"
}

output "subnetwork_name" {
  description = "GCPのサブネットワーク名"
  value       = "${google_compute_subnetwork.custom-subnetwork.name}"
}

output "ip_cidr_range" {
  description = "GCPのサブネットワークのIPアドレス範囲"
  value       = "${google_compute_subnetwork.custom-subnetwork.ip_cidr_range}"
}

output "subnetwork_secondary_ip_range_for_pod_name" {
  description = "GCPのサブネットワークのセカンダリIPレンジの名前（for pod）"
  value       = "${var.subnetwork_secondary_ip_range_for_pod_name}"
}

output "subnetwork_secondary_ip_range_for_svc_name" {
  description = "GCPのサブネットワークのセカンダリIPレンジの名前（for svc）"
  value       = "${var.subnetwork_secondary_ip_range_for_svc_name}"
}

output "subnetwork_secondary_ip_cidr_range_for_pod" {
  description = "GCPのサブネットワークのセカンダリIP cidr range（for pod）"
  value       = "${var.subnetwork_secondary_ip_cidr_range_for_pod[local.environment]}"
}

output "subnetwork_secondary_ip_cidr_range_for_svc" {
  description = "GCPのサブネットワークのセカンダリIP cidr range（for svc）"
  value       = "${var.subnetwork_secondary_ip_cidr_range_for_svc[local.environment]}"
}
