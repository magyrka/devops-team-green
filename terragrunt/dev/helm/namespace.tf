# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
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
#    name = "terraform-schedule-namespace"
#  }
#}

#data "google_container_cluster" "my_cluster" {
#  name     = module.cluster.cluster_id
#  location = module.cluster.cluster_location
#}
#
#output "cluster_endpoint" {
#  value = data.google_container_cluster.my_cluster.endpoint
#}
#provider "helm" {
#  kubernetes {
#    host                   = data.aws_eks_cluster.cluster.endpoint
#    token                  = data.aws_eks_cluster_auth.cluster.token
#    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#  }
#}
# https://stackoverflow.com/questions/70962800/error-kube-system-configmaps-dial-tcp-127-0-0-180-connect-connection-refused