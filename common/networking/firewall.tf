resource "google_compute_firewall" "allow-aws-internal" {
  name    = "allow-aws-internal"
  network = "${google_compute_network.custom-network.name}"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "allow-https" {
  name    = "allow-https"
  network = "${google_compute_network.custom-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_firewall" "sample-dev-allow-http" {
  name    = "sample-dev-allow-http"
  network = "${google_compute_network.custom-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http-server"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  network = "${google_compute_network.custom-network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  priority = 65534
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "${google_compute_network.custom-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  priority = 65534
}
