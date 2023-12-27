output "ip_private_psql" {
  value = google_sql_database_instance.postgres.ip_address.0.ip_address
}

output "pg_passw" {
  sensitive = true
  value     = data.google_secret_manager_secret_version.postgres_password.secret_data
}
