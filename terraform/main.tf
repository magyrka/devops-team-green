# ---------- Define our Modules ------------
module "vpc-dev" {
  source     = "./modules/gcp_network"
  cidr_range = var.cidr_range
  vpc_name   = "t-vpc-${var.env}"
  region     = var.region
  env        = var.env
  project_id = var.gcp_project_id
}

module "instance-jenkins" {
  source            = "./modules/gcp_instance"
  instance_name     = "jenkins-${var.env}"
  count             = var.instance_count
  machine_type      = "e2-micro" # 2 vCPU + 1 GB memory
  subnet_id         = module.vpc-dev.subnet_1_id
  delete_protection = false # true
  zone              = var.zone
}

module "instance-mongo" {
  source        = "./modules/gcp_instance"
  instance_name = "mongo-${var.env}"
  count         = 1
  machine_type  = "e2-micro"
  zone          = var.zone
  subnet_id     = module.vpc-dev.subnet_1_id
}

module "postgres-14" {
  source          = "./modules/gcp_psql"
  env             = var.env
  region          = var.region
  private_vpc_con = module.vpc-dev.private_vpc_con
  vpc_id          = module.vpc-dev.google_compute_network_ID
}

module "cluster" {
  source            = "./modules/gcp_cluster"
  env               = var.env
  zone              = var.zone
  network_ID        = module.vpc-dev.google_compute_network_ID
  subnet_id         = module.vpc-dev.subnet_1_id
  count_nodes       = 1
  serv_account      = var.serv_account
  node_machine_type = "e2-small"
}

module "helm" {
  # install our application via helm, source on repo
  source     = "./modules/gcp_helm"
  kuber_host = "https://${module.cluster.cluster_endpoint}"
  env        = var.env
  repository = var.chart_repository
  chart_name = var.chart_name
  namespace  = "default"

  client_certificate     = module.cluster.client_certificate
  client_key             = module.cluster.client_key
  cluster_ca_certificate = module.cluster.cluster_ca_certificate

  app = {
    name          = "schedule-helm"
    deploy        = 1
    chart         = "schedule-app"
    wait          = false
    recreate_pods = false
    version       = "0.1.2"
  }

  set = [
    #    https://github.com/terraform-module/terraform-helm-release
    {
      name  = "appName"
      value = "schedule-app"
    },
    {
      name  = "namespace"
      value = "default"
    },
    {
      name  = "backend_image.name"
      value = "stratiiv/devops-team-green"
    },
    {
      name  = "backend_image.tag"
      value = "latest"
    },
    {
      name  = "PG_USER"
      value = "schedule"
    },
    {
      name  = "PG_HOST"
      value = module.postgres-14.ip_private_psql
    },
    {
      name  = "PG_PASS"
      value = data.google_secret_manager_secret_version.postgres_password.secret_data
    },
  ]
}
