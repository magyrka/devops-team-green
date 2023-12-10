include "root" {
  path = find_in_parent_folders()
}
# -----------  WILL USE OWN (Custom) MODULE Kuber Helm -----------


terraform {
#  https://registry.terraform.io/modules/terraform-module/release/helm/latest
  source = "tfr:///terraform-module/release/helm?version=2.8.1"
}
#terraform {
#  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm?ref=DTG-75-Add-Helm-to-terraform"
##  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_cluster"
#}

#dependency "pg_db" {
#  config_path                             = "../pg_db"
#  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
#  mock_outputs = {
#    ip_private_psql = "10.10.10.10"
#    source  = "terraform-google-modules/kubernetes-engine/google"
#  }
#}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  chart            = local.environment_vars.locals.chart
  app        = local.environment_vars.locals.app
  namespace = local.environment_vars.locals.namespace
  repository = local.environment_vars.locals.repository
}

inputs = {
  app = "${local.app}"
  namespace = "${local.namespace}"
  repository = "${local.repository}"


#  pg_host   = dependency.pg_db.outputs.ip_private_psql
#  env          = "${local.env}"
#  chart_repository  = "${local.chart_repository}"
#  chart_name  = "${local.chart}"

}
