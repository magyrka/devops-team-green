include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_helm?ref=DTG-102-fix-mock-output-in-terragrunt-secrets"
  # source = "tfr:///terraform-module/release/helm?version=2.8.1"
}

dependencies {
  paths = ["../kubernetes", "../helm_consul", "../helm_backend"]
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

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  app              = local.environment_vars.locals.app_front
  repository       = local.environment_vars.locals.repo_front
  chart_n          = local.environment_vars.locals.chart_front
  namespace_app    = local.environment_vars.locals.namespace
  zone             = local.environment_vars.locals.zone
  fe_img_name      = local.environment_vars.locals.frontend_image_name
  fe_img_tag       = local.environment_vars.locals.frontend_image_tag
}

inputs = {
  app        = "${local.app}"
  env        = "${local.env}"
  zone       = "${local.zone}"
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
      name  = "frontend_image.name"
      value = get_env("IMAGE_NAME", "${local.fe_img_name}")
    },
    {
      name  = "frontend_image.tag"
      value = get_env("FR_IMAGE_DEV_TAG", "${local.fe_img_tag}")
    },
  ]
  cluster_ca_certificate = dependency.cluster_ip.outputs.cluster_ca_certificate
  client_certificate     = dependency.cluster_ip.outputs.client_certificate
  client_key             = dependency.cluster_ip.outputs.client_key
}