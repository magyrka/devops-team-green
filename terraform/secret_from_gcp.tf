# ======================= Get From Secrets Manager ===================

data "google_secret_manager_secret_version" "postgres_password" {
  secret = "PG_PASSWORD"
}
output "pasw_data" {
  sensitive = true
  value     = data.google_secret_manager_secret_version.postgres_password.secret_data
}


