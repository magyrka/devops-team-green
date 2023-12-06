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
  type        = list(string)
  description = "List of The range of internal addresses that are owned by this subnetwork."
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "instance_count" {
  type = number
}

