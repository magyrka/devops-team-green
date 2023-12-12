provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    host        = var.kuber_host
    insecure    = true
  }
}