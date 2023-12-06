resource "google_container_cluster" "primary" {
  name                = "tf-cluster-${var.env}"
  location            = var.zone
  network             = module.vpc-dev.google_compute_network_ID
  subnetwork          = module.vpc-dev.subnet_1_id
  deletion_protection = false # can be deleted

  remove_default_node_pool = true
  initial_node_count       = 1
  logging_service          = "logging.googleapis.com/kubernetes" # Defaults
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "node-pool-${var.env}"
  location   = var.region
  cluster    = google_container_cluster.primary.id
  node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 4
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    labels = {
      author = "vitaliy-k"
    }

    service_account = "awx-350@cisco-team-green.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
