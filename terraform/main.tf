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
  pub_key_path      = var.pub_key_path
}

module "instance-mongo" {
  source        = "./modules/gcp_instance"
  instance_name = "mongo-${var.env}"
  count         = 1
  machine_type  = "e2-micro"
  zone          = var.zone
  subnet_id     = module.vpc-dev.subnet_1_id
  pub_key_path  = var.pub_key_path
}


# ------------------------------- OUTPUT ------------------------
output "Terraform_google_compute_network" {
  value = module.vpc-dev.google_compute_network_ID
}