include "root" {
  path = find_in_parent_folders()
}

terraform {
#  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm"
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm?ref=DTG-75-Add-Helm-to-terraform"
}

dependency "cluster_ip" {
  config_path = "../kubernetes"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    cluster_endpoint = "10.10.10.10"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
#  app              = local.environment_vars.locals.app_consul
  namespace        = local.environment_vars.locals.namespace
#  repository       = local.environment_vars.locals.repository
  chart_n          = local.environment_vars.locals.chart_name
}

inputs = {
#  app        = "${local.app_consul}"
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  client_certificate = dependency.cluster_ip.outputs.client_certificate
  client_key = dependency.cluster_ip.outputs.client_key
  app        = {
    name          = "consul-helm"
    deploy        = 1
    chart         = "consul"
    wait          = false
    recreate_pods = false
    version       = "10.14.5"
  }
#  https://github.com/bitnami/charts/blob/main/bitnami/consul/values.yaml#L160
  set = [
    {
      name  = "service.type"
      value = "LoadBalancer"
    },
    {
      name = "replicaCount"
      value = 1
    },
#    {
#      name = "podLabels"
#      value = "{\"app\": \"schedule-app\"}"
#      value =  "{app=schedule-app}"
#    }
  ]
  env        = "${local.env}"
  namespace  = "consul"
  chart_name = "consul"
  repository =  "https://charts.bitnami.com/bitnami"
  kuber_host = "https://${dependency.cluster_ip.outputs.cluster_endpoint}"
}