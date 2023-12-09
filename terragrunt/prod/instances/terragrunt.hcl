include "root" {
  path = find_in_parent_folders()
}
# -----------  WILL USE OWN (Custom) MODULE Kuber CLUSTER -----------

terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_instance"
}
dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    subnet_1_id = "projects/cisco-team-green/regions/us-west2/subnetworks/tf-subnet-dev-0"
    google_compute_network_ID = "projects/cisco-team-green/global/networks/tf-vpc-prod"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  zone             = local.environment_vars.locals.zone
}

inputs = {
  instance_name = "mongo-${local.env}"
  count         = 1
  machine_type  = "e2-micro"
  zone          = "${local.zone}"
  subnet_id     = dependency.vpc.outputs.subnet_1_id
  env           = "${local.env}"
}
