include "root" {
  path = find_in_parent_folders()
}
# -----------  WILL USE OWN (Custom) MODULE -----------

terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_network"
}

locals {
  base_source_url = "tfr:///terraform-google-modules/network/google"

  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  region           = local.environment_vars.locals.region
  project_id       = local.environment_vars.locals.project_id
  cidr_range       = local.environment_vars.locals.cidr_range
}

inputs = {
  cidr_range = "${local.cidr_range}"
  vpc_name   = "tg-${local.env}"
  region     = "${local.region}"
  env        = "${local.env}"
  project_id = "${local.project_id}"
}
