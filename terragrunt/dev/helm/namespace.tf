# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
resource "kubernetes_namespace" "app" {
  metadata {
    annotations = {
      name = "app"
    }

    labels = {
      author = "vitaliy"
    }

    name = "terraform-schedule-namespace"
  }
}