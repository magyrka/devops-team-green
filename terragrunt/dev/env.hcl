locals {
  environment              = "dev"
  cidr_range               = ["10.0.12.0/24", "10.0.13.0/24"]
  region                   = "us-west2"
  zone                     = "us-west2-b"
  project_id               = "cisco-team-green"
  count_nodes              = 1
  kubernetes_instance_type = "e2-small"
  serv_account             = "awx-350@cisco-team-green.iam.gserviceaccount.com"
  app = {
    name ="schedule-app"
    deploy        = 1
    chart         = "nginx-ingress"
    wait          = false
    recreate_pods = false
    version       = "0.17.1"
  }
  namespace = "app"
#  repository = "https://github.com/Vitalikys/chart.git"
#  repository = "s3://vit-helm.io/charts"
#  chart  ="schedule/schedule-app"
  repository = "https://helm.nginx.com/stable"
  chart  ="nginx-ingress"
#  chart  ="kubernetes/schedule-app/Chart"
}