variable "cidr_range" {
  type        = list(string)
  description = "List of The range of internal addresses that are owned by this subnetwork."
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "vpc_name" {
  default = "tf-network"
  type    = string
}

variable "region" {
  description = "Google region"
  type        = string
  default     = "europe-west9" # Paris
}

variable "zone" {
  default = "europe-west9-a"
}

variable "gcp_project_id" {
  description = "Google Project ID"
  type        = string
  default     = "cisco-team-green"
}

variable "env" {
  type        = string
  description = "env to use"
}