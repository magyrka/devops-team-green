locals {
  environment = "prod"
  cidr_range  = "10.0.32.0/24"
  region      = "us-west2"
  zone        = "us-west2-b"
  project_id  = "cisco-team-green"
  kubernetes_instance_type = "e2-small"
}