resource "google_container_cluster" "primary" {
  #  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
  name                = "cluster-${var.env}"
  description         = "Custom module"
  location            = var.zone
  network             = var.network_ID
  subnetwork          = var.subnet_id
  deletion_protection = false # can be deleted

  remove_default_node_pool = true
  initial_node_count       = 1
  logging_service          = "logging.googleapis.com/kubernetes" # Defaults
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  #  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
  name       = "node-pool-${var.env}"
  location   = var.zone
  cluster    = google_container_cluster.primary.id
  node_count = var.count_nodes
  node_config {
    preemptible  = true
    machine_type = var.node_machine_type
    disk_size_gb = 38

    labels = {
      author = "vitaliy-k"
    }
    service_account = var.serv_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
