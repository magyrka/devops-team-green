include "root" {
  path = find_in_parent_folders()
}

terraform {
  #  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm"
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm?ref=DTG-75-Add-Helm-to-terraform"
}

dependency "cluster_ip" {
  config_path                             = "../kubernetes"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    cluster_endpoint       = "10.10.10.10"
    cluster_ca_certificate = "mock"
    client_certificate     = "mock"
    client_key             = "mock"
  }
}

dependency "cluster_namespaces" {
  config_path  = "../kuber_namespaces"
  skip_outputs = true
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  app              = local.environment_vars.locals.app_consul
  namespace        = local.environment_vars.locals.namespace
  chart_n          = local.environment_vars.locals.chart_name
  #  repository       = local.environment_vars.locals.repository
}

inputs = {
  app = {
    name             = "consul-tg"
    deploy           = 1
    chart            = "consul"
    wait             = false
    recreate_pods    = false
    version          = "1.3.0"
    create_namespace = true
  }
  values                 = ["${file("consul-config.yaml")}"]
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  client_certificate     = dependency.cluster_ip.outputs.client_certificate
  client_key             = dependency.cluster_ip.outputs.client_key

  env        = "${local.env}"
  namespace  = "consul"
  chart_name = "consul"
  repository = "https://helm.releases.hashicorp.com"
  kuber_host = "https://${dependency.cluster_ip.outputs.cluster_endpoint}"
}