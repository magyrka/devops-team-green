variable "instance_name" {
  default = "Ubuntu-22"
}

variable "instance_count" {
  default = 1
}

variable "zone" {
  description = "zone, for example: europe-west9-a"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "subnet_id" {
  description = "Take it from Net module"
}

variable "delete_protection" {
  default = false
}
variable "pub_key_ssh" {
  description = "Public SSH key to access to instance"
  default     = ""
}