resource "google_compute_network" "custom-network" {
  name                    = "${var.network_name[local.environment]}"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_subnetwork" "custom-subnetwork" {
  name                     = "${var.subnetwork_name[local.environment]}"
  ip_cidr_range            = "${var.subnetwork_ip_cidr_range[local.environment]}"
  network                  = "${google_compute_network.custom-network.self_link}"
  region                   = "${local.region}"
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.subnetwork_secondary_ip_range_for_pod_name}"
    ip_cidr_range = "${var.subnetwork_secondary_ip_cidr_range_for_pod[local.environment]}"
  }

  secondary_ip_range {
    range_name    = "${var.subnetwork_secondary_ip_range_for_svc_name}"
    ip_cidr_range = "${var.subnetwork_secondary_ip_cidr_range_for_svc[local.environment]}"
  }

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_address" "vpn-aws-gip" {
  name        = "vpn-aws-gip"
  description = "for vpn-aws-gip"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_address" "vpn-aws-gip-2" {
  name        = "vpn-aws-gip-2"
  description = "for vpn-aws-gip-2"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_router" "vpn-aws-gip-router" {
  name        = "vpn-aws-gip-router"
  network     = "${google_compute_network.custom-network.self_link}"
  description = "for vpn-aws-gip"

  bgp {
    asn            = 65000
    advertise_mode = "DEFAULT"
  }

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_vpn_gateway" "vpn-aws-gip-1" {
  name    = "vpn-aws-gip-1"
  network = "${google_compute_network.custom-network.name}"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_vpn_gateway" "vpn-aws-gip-2" {
  name    = "vpn-aws-gip-2"
  network = "${google_compute_network.custom-network.name}"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_vpn_tunnel" "vpn-aws-gip-1-tunnel-1" {
  name               = "vpn-aws-gip-1-tunnel-1"
  router             = "${google_compute_router.vpn-aws-gip-router.self_link}"
  ike_version        = 1
  peer_ip            = "52.26.106.11"
  shared_secret      = "NzOQQcUAhlbDp6O.4iY3TSlBCxpekymz"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn-aws-gip-1.self_link}"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_vpn_tunnel" "vpn-aws-gip-1-tunnel-2" {
  name               = "vpn-aws-gip-1-tunnel-2"
  router             = "${google_compute_router.vpn-aws-gip-router.self_link}"
  ike_version        = 1
  peer_ip            = "52.40.15.250"
  shared_secret      = "YpIta4cLwsfd2K_FwVSuojWvWtehdIw1"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn-aws-gip-1.self_link}"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_vpn_tunnel" "vpn-aws-gip-2-tunnel-1" {
  name               = "vpn-aws-gip-2-tunnel-1"
  router             = "${google_compute_router.vpn-aws-gip-router.self_link}"
  ike_version        = 1
  peer_ip            = "52.34.187.35"
  shared_secret      = "JwfV3X3rzHJwngp3qU.j5p1CKGg37Z0X"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn-aws-gip-2.self_link}"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_vpn_tunnel" "vpn-aws-gip-2-tunnel-2" {
  name               = "vpn-aws-gip-2-tunnel-2"
  router             = "${google_compute_router.vpn-aws-gip-router.self_link}"
  ike_version        = 1
  peer_ip            = "54.149.198.213"
  shared_secret      = "sIVrDss17LBceu5GaFJ85ZTzPKPZpN.L"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn-aws-gip-2.self_link}"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_router_peer" "vpn-aws-gip-1-tunnel-1-bgp" {
  name                      = "vpn-aws-gip-1-tunnel-1-bgp"
  router                    = "${google_compute_router.vpn-aws-gip-router.name}"
  region                    = "${local.region}"
  peer_ip_address           = "169.254.12.41"
  peer_asn                  = "${var.vpn_peer_asn}"
  advertised_route_priority = 0
  interface                 = "if-vpn-aws-gip-1-tunnel-1-bgp"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_router_peer" "vpn-aws-gip-1-tunnel-2-bgp" {
  name                      = "vpn-aws-gip-1-tunnel-2-bgp"
  router                    = "${google_compute_router.vpn-aws-gip-router.name}"
  region                    = "${local.region}"
  peer_ip_address           = "169.254.12.33"
  peer_asn                  = "${var.vpn_peer_asn}"
  advertised_route_priority = 0
  interface                 = "if-vpn-aws-gip-1-tunnel-2-bgp"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_router_peer" "vpn-aws-gip-2-tunnel-1-bgp" {
  name                      = "vpn-aws-gip-2-tunnel-1-bgp"
  router                    = "${google_compute_router.vpn-aws-gip-router.name}"
  region                    = "${local.region}"
  peer_ip_address           = "169.254.13.241"
  peer_asn                  = "${var.vpn_peer_asn}"
  advertised_route_priority = 0
  interface                 = "if-vpn-aws-gip-2-tunnel-1-bgp"

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "google_compute_router_peer" "vpn-aws-gip-2-tunnel-2-bgp" {
  name                      = "vpn-aws-gip-2-tunnel-2-bgp"
  router                    = "${google_compute_router.vpn-aws-gip-router.name}"
  region                    = "${local.region}"
  peer_ip_address           = "169.254.13.49"
  peer_asn                  = "${var.vpn_peer_asn}"
  advertised_route_priority = 0
  interface                 = "if-vpn-aws-gip-2-tunnel-2-bgp"

  // lifecycle {
  //   prevent_destroy = true
  // }
}
