include "root" {
  path = find_in_parent_folders()
}
# -----------  WILL USE OWN (Custom) MODULE -----------

terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_psql?ref=DTG-73-Move-TF-to-Terragrunt"
}
dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    private_vpc_con           = "projects%2Fcisco-team-green%2Fglobal%2Fnetworks%2Ftf-vpc-prod:servicenetworking.googleapis.com"
    google_compute_network_ID = "projects/cisco-team-green/global/networks/tf-vpc-prod"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  region           = local.environment_vars.locals.region
  project_id       = local.environment_vars.locals.project_id
}

inputs = {
  #  https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency
  private_vpc_con = dependency.vpc.outputs.private_vpc_con
  vpc_id          = dependency.vpc.outputs.google_compute_network_ID
  env             = "${local.env}"
  vpc_name        = "tg-${local.env}"
  region          = "${local.region}"
  project_id      = "${local.project_id}"
}