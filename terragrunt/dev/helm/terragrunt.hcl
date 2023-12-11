##include "root" {
##  path = find_in_parent_folders()
##}
#
#terraform {
#  #  https://registry.terraform.io/modules/terraform-module/release/helm/latest
#  source = "tfr:///terraform-module/release/helm?version=2.8.1"
#}
#
#dependency "pg_db" {
#  config_path                             = "../pg_db"
#  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
#  mock_outputs = {
#    ip_private_psql = "10.10.10.10"
#    source          = "terraform-google-modules/kubernetes-engine/google"
#  }
#}
#
#locals {
#  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
#  env              = local.environment_vars.locals.environment
#  app              = local.environment_vars.locals.app
#  namespace        = local.environment_vars.locals.namespace
#  repository       = local.environment_vars.locals.repository
#}
#
#inputs = {
#  app        = "${local.app}"
#  namespace  = "${local.namespace}"
#  repository = "${local.repository}"
#  set = [
#    #    https://github.com/terraform-module/terraform-helm-release
#    {
#      name  = "appName"
#      value = "schedule-app"
#    },
#    {
#      name  = "namespace"
#      value = "app"
#    },
#    {
#      name  = "backend_image.name"
#      value = "stratiiv/devops-team-green"
#    },
#    {
#      name  = "backend_image.tag"
#      value = "latest"
#    },
#    {
#      name  = "PG_USER"
#      value = "schedule"
#    },
#    {
#      name  = "PG_HOST"
#      value = dependency.pg_db.outputs.ip_private_psql
#    },
#    {
#      name  = "PG_PASS"
#      value = "schedule"
#    },
#  ]
#
#  #  set_sensitive = [
#  #    {
#  #      name  = "PG_PASS"
#  #      value = "schedule"
#  #    },
#  #  ]
#
#}
