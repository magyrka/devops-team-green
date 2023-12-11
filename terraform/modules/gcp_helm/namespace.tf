#resource "kubernetes_namespace" "app" {
#  metadata {
#    annotations = {
#      name = "app"
#    }
#
#    labels = {
#      author = "vitaliy"
#    }
#
#    name = "app"
#  }
#}