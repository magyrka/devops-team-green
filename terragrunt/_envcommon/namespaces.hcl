terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_namespaces?ref=DTG-102-fix-mock-output-in-terragrunt-secrets"
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
  env              = local.environment_vars.locals.environment
  zone             = local.environment_vars.locals.zone
}

inputs = {
  env                    = "${local.env}"
  zone                   = "${local.zone}"
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  namespace              = ["consul", "app", "monitoring", "customnames"]
  kuber_host             = "https://${dependency.cluster_ip.outputs.cluster_endpoint}"
}
