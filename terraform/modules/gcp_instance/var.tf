variable "instance_name" {
  default = "Ubuntu-22"
}

variable "instance_count" {
  default = 1
}

variable "zone" {
  default = "europe-west9-a"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
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
  type = string
}

variable "subnet_id" {
  default = "Take it from Net"
}

variable "delete_protection" {
  default = false
}