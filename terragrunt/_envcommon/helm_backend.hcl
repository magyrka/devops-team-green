terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm"
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
    cluster_endpoint       = "10.10.10.10"
    cluster_ca_certificate = ""
    client_certificate     = ""
    client_key             = ""
  }
}

dependency "cluster_namespaces" {
  config_path  = "../kuber_namespaces"
  skip_outputs = true
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  app              = local.environment_vars.locals.app
  repository       = local.environment_vars.locals.repo_front
  chart_n          = local.environment_vars.locals.chart_front
  namespace_app    = local.environment_vars.locals.namespace
}

inputs = {
  app        = "${local.app}"
  env        = "${local.env}"
  namespace  = "${local.namespace_app}"
  chart_name = "${local.chart_n}"
  repository = "${local.repository}"
  kuber_host = "https://${dependency.cluster_ip.outputs.cluster_endpoint}"
  set = [
    #    https://github.com/terraform-module/terraform-helm-release
    {
      name  = "service.name"
      value = "frontend"
    },
    {
      name  = "namespace"
      value = "${local.namespace_app}"
    },
    {
      name  = "backend_image.name"
      value = get_env("IMAGE_NAME", "stratiiv/devops-team-green")
    },
    {
      name  = "frontend_image.tag"
      value = get_env("IMAGE_DEV_TAG", "v1")
    },
    {
      name  = "postgres.db_user"
      value = "schedule"
    },
    {
      name  = "postgres.db_host"
      value = dependency.pg_db.outputs.ip_private_psql
    },
#    "${dependency.pg_db.pg_passw}"
    {
      name  = "postgres.db_password"
      value = "schedule"
    },
    {
      name  = "mongodb.host"
      value = "10.0.12.13"
    },
  ]

  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  client_certificate     = dependency.cluster_ip.outputs.client_certificate
  client_key             = dependency.cluster_ip.outputs.client_key
}