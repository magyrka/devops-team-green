#include "root" {
#  path = find_in_parent_folders()
#}
#
#terraform {
#  #  https://registry.terraform.io/modules/terraform-module/release/helm/latest
#  source = "tfr:///terraform-module/release/helm?version=2.8.1"
#}
#
#inputs = {
##  https://github.com/hashicorp/consul-k8s/tree/main/charts/consul
#  app        = {
#    name          = "consul"
#    deploy        = 1
#    chart         = "consul"
#    wait          = false
#    recreate_pods = false
#    version       = "1.4.0-dev"
#  }
#  namespace  = "app"
#  repository = "https://helm.releases.hashicorp.com"
#}
