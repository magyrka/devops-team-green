variable "env" {
  type = string
}
variable "zone" {
  type = string
}
variable "network_ID" {
  type = string
}

variable "subnet_id" {
  type        = string
  description = "Take it from Net module"
}

variable "count_nodes" {
  type = number
}
variable "serv_account" {
  type = string
}