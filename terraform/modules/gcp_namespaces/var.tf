variable "env" {
  type = string
}

variable "zone" {
  type = string
}

variable "kuber_host" {
  description = "url to reach Cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "Base64-encoded Kubernetes cluster CA certificate used for server verification."
}

variable "namespace" {
  default = ["consul", "app", "monitoring"]
  type    = list(string)
}
