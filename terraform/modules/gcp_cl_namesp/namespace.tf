variable "namespace" {
  default = "app"
}

#https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
resource "kubernetes_namespace" "app" {
  wait_for_default_service_account = true
  metadata {
    labels = {
      author = "vitaliy"
    }
    name = var.namespace
  }
}

#resource "null_resource" "cluster" {
#  connection {
#    host = var.kuber_host
#  }
#  provisioner "remote-exec" {
#    inline = [
#      "kubectl create  namespace app-23",
#    ]
#  }
#}