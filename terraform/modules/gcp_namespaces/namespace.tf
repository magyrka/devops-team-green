variable "namespace" {
  default = ["consul", "app", "monitoring"]
  type    = list(string)
}

#https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
resource "kubernetes_namespace" "app" {
  count                            = length(var.namespace)
  wait_for_default_service_account = true
  metadata {
    labels = {
      author = "vitaliy"
    }
    name = var.namespace[count.index]
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