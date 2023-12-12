variable "env" {
  type = string
}

variable "chart_name" {
  type = string
}

variable "chart_repository" {
  default = "https://github.com/DTG-cisco/devops-team-green-2/tree/DTG-73-Move-TF-to-Terragrunt/kubernetes/schedule-app"
}

variable "kuber_host" {
  description = "url to reach Cluster"
  type        = string
  default     = "https://34.102.65.77"
}

variable "pg_host" {
  type = string
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
