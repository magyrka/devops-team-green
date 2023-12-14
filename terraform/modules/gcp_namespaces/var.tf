variable "kuber_host" {
  description = "url to reach Cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "Base64-encoded Kubernetes cluster CA certificate used for server verification."
}

variable "client_certificate" {
  description = "Base64-encoded client certificate used for authentication with the Kubernetes cluster."
}

variable "client_key" {
  description = "Base64-encoded client private key used for authentication with the Kubernetes cluster."
}

variable "namespace" {
  default = ["consul", "app", "monitoring"]
  type    = list(string)
}
