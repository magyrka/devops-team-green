variable "region" {
  description = "Google region"
  type        = string
}

variable "env" {
  type        = string
  description = "env to use"
}


variable "private_vpc_con" {
  description = "Take it from module"
}
variable "vpc_id" {
  description = "VPC ID, Take it from module"
}
