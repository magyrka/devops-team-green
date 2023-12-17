provider "kubernetes" {
  config_path = "~/.kube/config"
  host        = var.kuber_host
  #  insecure    = true

  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
}


