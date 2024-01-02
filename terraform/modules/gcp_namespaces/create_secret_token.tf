# This part to Save Cluster Token in GCP Secret Manager
resource "google_secret_manager_secret" "cluster-token" {
  secret_id = "CLUSTER-TOKEN-${var.env}"
 replication {
    user_managed {
      replicas {
        location = "us-west2"
      }
    }
  }
}

resource "google_secret_manager_secret_version" "cluster-token" {
  secret      = google_secret_manager_secret.cluster-token.id
  secret_data = data.google_client_config.default.access_token
}