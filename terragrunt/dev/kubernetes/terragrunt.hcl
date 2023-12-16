include "root" {
  path = find_in_parent_folders()
}
# -----------  WILL USE OWN (Custom) MODULE Kuber CLUSTER -----------

terraform {
  #  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_cluster"
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_cluster?ref=DTG-75-Add-Helm-to-terraform"
}
dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    subnet_1_id               = "projects/mock/tg-vpc-dev"
    google_compute_network_ID = "projects/mock/tf-vpc-prod"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  region           = local.environment_vars.locals.region
  project_id       = local.environment_vars.locals.project_id
  zone             = local.environment_vars.locals.zone
  count_nodes      = local.environment_vars.locals.count_nodes
  serv_account     = local.environment_vars.locals.serv_account
  node_clust_type  = local.environment_vars.locals.node_machine_type
}

inputs = {
  network_ID   = dependency.vpc.outputs.google_compute_network_ID
  subnet_id    = dependency.vpc.outputs.subnet_1_id
  env          = "${local.env}"
  zone         = "${local.zone}"
  count_nodes  = "${local.count_nodes}"
  region       = "${local.region}"
  serv_account = "${local.serv_account}"
  node_machine_type = "${local.serv_account}"
}

#dependencies {
#  paths = ["../vpc"]
#}