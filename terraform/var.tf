variable "region" {
  description = "Google region"
  type        = string
  default     = "us-west1"
}

variable "env" {
  default     = "dev"
  type        = string
  description = "env to use"
}

variable "zone" {
  type        = string
  description = "Zone where provider will operate. "
  default     = "us-west1-b"
}

variable "credentials_json" {
  description = "Json File with Credentials"
  default     = "./cisco-team-green.json"
}

variable "gcp_project_id" {
  description = "Google Project ID"
  type        = string
  default     = "cisco-team-green"
}

variable "pub_key_path" {
  default = "./id_rsa.pub"
  type    = string
}

variable "cidr_range" {
  type        = string
  description = "The range of internal addresses that are owned by this subnetwork."

}

variable "instance_count" {
  type = number
}

variable "serv_account" {
  description = "e-mail service account"
}

variable "chart_name" {
  type = string
}

variable "chart_repository" {
  default = "https://github.com/DTG-cisco/devops-team-green-2/tree/DTG-72_helm/kubernetes/schedule-app"
}
