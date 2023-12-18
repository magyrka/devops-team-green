locals {
  environment       = "dev"
  cidr_range        = "10.0.22.0/24"
  region            = "us-west1"
  zone              = "us-west1-b"
  project_id        = "cisco-team-green"
  count_nodes       = 3
  node_machine_type = "e2-small"
  serv_account      = "awx-350@cisco-team-green.iam.gserviceaccount.com"
  app = {
    name             = "schedule-helm"
    deploy           = 1
    chart            = "schedule-app"
    wait             = false
    recreate_pods    = false
    version          = "0.1.2"
    create_namespace = true
  }

  app_consul = {
    name             = "consul"
    deploy           = 1
    chart            = "consul"
    wait             = false
    recreate_pods    = false
    version          = "1.3.0"
    create_namespace = true
  }

  # For Application
  namespace  = "default"
  repository = "https://vitalikys.github.io/chart/"
  chart_name = "schedule-app"
}