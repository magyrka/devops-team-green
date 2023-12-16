include "root" {
  path = find_in_parent_folders()
}

terraform {
  #  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm"
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm?ref=DTG-75-Add-Helm-to-terraform"
}
dependency "pg_db" {
  config_path                             = "../pg_db"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    ip_private_psql = "10.10.10.10"
    source          = "terraform-google-modules/kubernetes-engine/google"
  }
}

dependency "cluster_ip" {
  config_path                             = "../kubernetes"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    cluster_endpoint = "10.10.10.10"
    cluster_ca_certificate = ""
    client_certificate    = ""
    client_key = ""
  }
}

#dependency "cluster_namespaces" {
#  config_path = "../kuber_namespaces"
#  skip_outputs = true
#}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  app              = local.environment_vars.locals.app
  repository       = local.environment_vars.locals.repository
  chart_n          = local.environment_vars.locals.chart_name
}

inputs = {
  app        = "${local.app}"
  env        = "${local.env}"
  namespace  = "app"
  chart_name = "${local.chart_n}"
  repository = "${local.repository}"
  kuber_host = "https://${dependency.cluster_ip.outputs.cluster_endpoint}"
  set = [
    #    https://github.com/terraform-module/terraform-helm-release
    {
      name  = "appName"
      value = "schedule-app"
    },
    {
      name  = "namespace"
      value = "app"
    },
    {
      name  = "backend_image.name"
      value = get_env("IMAGE_NAME", "stratiiv/devops-team-green")
    },
    {
      name  = "backend_image.tag"
      value = get_env("IMAGE_DEV_TAG", "latest")
    },
    {
      name  = "PG_USER"
      value = "schedule"
    },
    {
      name  = "PG_HOST"
      value = dependency.pg_db.outputs.ip_private_psql
    },
  ]

  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  client_certificate     = dependency.cluster_ip.outputs.client_certificate
  client_key             = dependency.cluster_ip.outputs.client_key

}
