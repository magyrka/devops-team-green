locals {
  onprem = [
    # here we set instance IP, which needs connection to DB "34.163.72.39",
    #        module.instance-jenkins.google_compute_instance_IP,
    #        module.instance-app-test.google_compute_instance_IP,
  ]
}

resource "google_sql_database_instance" "postgres" {
  #  https://registry.terraform.io/providers/hashicorp/google/5.5.0/docs/resources/sql_database_instance
  name                = "pg-14-${var.env}"
  database_version    = "POSTGRES_14"
  deletion_protection = false # true
  region              = var.region
  root_password       = data.google_secret_manager_secret_version.postgres_password.secret_data
  depends_on          = [var.private_vpc_con]

  settings {
    tier      = "db-f1-micro"
    disk_size = 12

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc_id
      enable_private_path_for_google_cloud_services = true
      dynamic "authorized_networks" {
        for_each = local.onprem
        iterator = onprem
        content {
          name  = "onprem-${onprem.key}"
          value = onprem.value
        }
      }
    }
  }
}

resource "google_sql_user" "users" {
  name     = "schedule"
  instance = google_sql_database_instance.postgres.name
  password = data.google_secret_manager_secret_version.postgres_password.secret_data

  depends_on = [google_sql_database_instance.postgres]
}

resource "google_sql_database" "database" {
  name     = "schedule"
  instance = google_sql_database_instance.postgres.name
}
data "google_secret_manager_secret_version" "postgres_password" {
  secret = "PG_PASSWORD"
}

output "ip_private_psql" {
  value =  google_sql_database_instance.postgres.ip_address.0.ip_address
}

