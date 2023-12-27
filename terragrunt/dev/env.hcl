locals {
  environment       = "dev"
  cidr_range        = "10.0.12.0/24"
  region            = "us-west2"
  zone              = "us-west2-b"
  project_id        = "cisco-team-green"
  count_nodes       = 3
  node_machine_type = "e2-medium"
  serv_account      = "awx-350@cisco-team-green.iam.gserviceaccount.com"

  # For Consul (helm)
  namespace = "consul"
  repository_consul = "https://helm.releases.hashicorp.com"
  chart_name_consul = "consul"
  app_consul = {
    name             = "consul"
    deploy           = 1
    chart            = "consul"
    wait             = false
    recreate_pods    = false
    version          = "1.3.0"
    create_namespace = true
  }

  # For Frontend App (helm)
  namespace_app  = "app"
  repo_front     = "https://dtg-cisco.github.io/helm-charts/"
  chart_front    = "frontend"
  app_front = {
    name             = "app-front"
    deploy           = 1
    chart            = "frontend"
    wait             = false
    recreate_pods    = false
    version          = "0.1.1"
    create_namespace = true
  }

  # For Backend App (helm)
  repo_back     = "https://dtg-cisco.github.io/helm-charts/"
  chart_back    = "backend"
  app_back = {
    name             = "app-back"
    deploy           = 1
    chart            = "backend"
    wait             = false
    recreate_pods    = false
    version          = "0.1.1"
    create_namespace = true
  }
}