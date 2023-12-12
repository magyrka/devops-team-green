#resource "kubernetes_namespace" "app" {
#  metadata {
#    annotations = {
#      name = var.namespace
#    }
#    labels = {
#      author = "vitaliy"
#    }
#    name = var.namespace
#  }
#}

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