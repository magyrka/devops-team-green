provider "helm" {
  kubernetes {
    #  config_path = "~/.kube/config"
    host                   = var.kuber_host
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

data "google_container_cluster" "default" {
  name     = "cluster-${var.env}"
  location = var.zone
}

data "google_client_config" "default" {}

output "token" {
  value     = data.google_client_config.default.access_token
  sensitive = true
}
