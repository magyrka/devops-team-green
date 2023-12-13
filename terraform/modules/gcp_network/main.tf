resource "google_compute_network" "vpc_network" {
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
  name                            = var.vpc_name
  auto_create_subnetworks         = false
  mtu                             = 1460 # Maximum transmission unit
  delete_default_routes_on_create = false
  routing_mode                    = "REGIONAL"
}

/*resource "google_compute_subnetwork" "private" {
  count                    = 2
  name                     = "tf-subnet-${var.env}-${count.index}"
  ip_cidr_range            = element(var.cidr_range, count.index)
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}*/

resource "google_compute_subnetwork" "private" {
  count                    = 1
  name                     = "tf-subnet-${var.env}"
  ip_cidr_range            = var.cidr_range
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "router-tf-${var.env}"
  region  = var.region
  network = google_compute_network.vpc_network.id
  bgp {
    asn = 64514
  }
}

resource "google_compute_global_address" "private_ip_address" {
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
  # https://registry.terraform.io/providers/hashicorp/google/5.5.0/docs/resources/sql_database_instance
  project       = var.gcp_project_id
  name          = "small-ip-address-${var.env}"
  purpose       = "VPC_PEERING" #  "PRIVATE_SERVICE_CONNECT"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  #  Manages a private VPC connection with a GCP service provider.
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


resource "google_compute_firewall" "ssh" {
  name = "allow-ssh-${var.env}"
  allow { protocol = "icmp" }
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"] # add instances here
}

resource "google_compute_firewall" "allow-8080" {
  name = "allow-ssh-80-8080-${var.env}"
  allow {
    ports    = ["80", "8080-8085"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
}


