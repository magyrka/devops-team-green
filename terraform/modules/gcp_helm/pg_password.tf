# ======================= Get From Secrets Manager ===================

data "google_secret_manager_secret_version" "pg_password" {
  secret = "PG_PASSWORD"
}
output "pg_passw" {
  sensitive = true
  value     = data.google_secret_manager_secret_version.pg_password.secret_data
}


