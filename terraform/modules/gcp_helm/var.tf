variable "env" {
  type = string
}

variable "chart_name" {
  type = string
}

variable "zone" {
  description = "zone where cluster is located, e.g. us-west2-b "
  type        = string
}

variable "kuber_host" {
  description = "url to reach Cluster"
  type        = string
}

variable "namespace" {
  description = "namespace where to deploy an application"
  type        = string
}

variable "app" {
  description = "an application to deploy"
  type        = map(any)
}

variable "repository_config" {
  description = "repository configuration"
  type        = map(any)
  default     = {}
}

variable "values" {
  description = "Extra values"
  type        = list(string)
  default     = []
}

variable "set" {
  description = "Value block with custom STRING values to be merged with the values yaml."
  type = list(object({
    name  = string
    value = string
  }))
  default = null
}

variable "set_sensitive" {
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  type = list(object({
    path  = string
    value = string
  }))
  default = null
}

variable "repository" {
  description = "Helm repository"
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
