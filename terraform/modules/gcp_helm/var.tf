variable "env" {
  type = string
}

variable "chart_name" {
  type = string
}

variable "chart_repository" {
  default = "https://github.com/DTG-cisco/devops-team-green-2/tree/DTG-73-Move-TF-to-Terragrunt/kubernetes/schedule-app"
}

variable "pg_host" {
  type = string
}