# ---------- Define our Modules ------------
module "vpc-dev" {
  source     = "./modules/gcp_network"
  cidr_range = var.cidr_range
  vpc_name   = "tf-vpc-${var.env}"
  region     = var.region
  env        = var.env

}

module "instance-jenkins" {
  source            = "./modules/gcp_instance"
  instance_name     = "jenkins-${var.env}"
  count             = var.instance_count
  machine_type      = "e2-micro" # 2 vCPU + 1 GB memory
  subnet_id         = module.vpc-dev.subnet_1_id
  delete_protection = false # true
}

module "instance-mongo" {
  source        = "./modules/gcp_instance"
  instance_name = "mongo-${var.env}"
  count         = 0
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
  source       = "./modules/gcp_cluster"
  env          = var.env
  zone         = var.zone
  network_ID   = module.vpc-dev.google_compute_network_ID
  subnet_id    = module.vpc-dev.subnet_1_id
  count_nodes  = 1
  serv_account = var.serv_account
}

module "helm" {
  source           = "./modules/gcp_helm"
  env              = var.env
  chart_repository = var.chart_repository
  chart_name       = var.chart_name
  pg_host          = module.postgres-14.ip_private_psql
}

# ------------------------------- OUTPUT ------------------------
output "Terraform_google_compute_network" {
  value = module.vpc-dev.google_compute_network_ID
}

output "psql_private_ip" {
  value = module.postgres-14.ip_private_psql
}