variable "cidr_range" {
  type        = string
  description = "The range of internal addresses that are owned by this subnetwork."
}

variable "vpc_name" {
  type = string
}

variable "region" {
  description = "Google region"
  type        = string
}

variable "zone" {
  default = "europe-west9-a"
}

variable "project_id" {
  description = "Google Project ID"
  type        = string
}

variable "env" {
  type        = string
  description = "env to use (prod,stage or dev)"
}