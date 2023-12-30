data "google_secret_manager_secret_version" "postgres_password" {
  secret = "PG_PASSWORD"
}

output "pg_passw" {
  sensitive = true
  value     = data.google_secret_manager_secret_version.postgres_password.secret_data
}

data "google_secret_manager_secret_version" "nexus_token" {
  secret = "NEXUS_TOKEN"
}

output "nexus_token" {
  sensitive = true
  value     = data.google_secret_manager_secret_version.nexus_token.secret_data
}
