locals {
  environment              = "dev"
  cidr_range               = "10.0.12.0/24"
  region                   = "us-west2"
  zone                     = "us-west2-b"
  project_id               = "cisco-team-green"
  count_nodes              = 1
  kubernetes_instance_type = "e2-small"
  serv_account             = "awx-350@cisco-team-green.iam.gserviceaccount.com"
  app = {
    name          = "schedule-helm"
    deploy        = 1
    chart         = "schedule-app"
    wait          = false
    recreate_pods = false
    version       = "0.1.2"
  }
  namespace  = "default"
  repository = "https://vitalikys.github.io/chart/"
  chart_name = "schedule-app"
}