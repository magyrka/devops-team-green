terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_namespaces"
}

dependencies {
  paths = ["../vpc", "../kubernetes"]
}

dependency "cluster_ip" {
  config_path                             = "../kubernetes"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    cluster_endpoint       = "10.10.10.10"
    cluster_ca_certificate = ""
    client_certificate     = ""
    client_key             = ""
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  namespace        = local.environment_vars.locals.namespace
}

inputs = {
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  client_certificate     = dependency.cluster_ip.outputs.client_certificate
  client_key             = dependency.cluster_ip.outputs.client_key
  namespace              = ["consul", "app", "monitoring", "customnames"]
  kuber_host             = "https://${dependency.cluster_ip.outputs.cluster_endpoint}"
}
