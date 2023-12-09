locals {
  environment = "prod"
  region      = "us-west2"
  zone        = "us-west2-b"
  project_id  = "cisco-team-green"
  cidr_range  = ["10.0.34.0/24", "10.0.35.0/24"]

  count_nodes              = 1
  kubernetes_instance_type = "e2-small"
  serv_account             = "awx-350@cisco-team-green.iam.gserviceaccount.com"
}