include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${local.base_source_url}?version=8.0.0"
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
  network_name = "tg-${local.env}"
  project_id  = "${local.project_id}"

  subnets = [
    {
      subnet_name   = "${local.env}-sub-01"
      subnet_ip     = "${local.cidr_range}"
      subnet_region = local.region
    },
  ]
}