
# ------------------------------- OUTPUT ------------------------
output "Terraform_google_compute_network" {
  value = module.vpc-dev.google_compute_network_ID
}

output "kuber_host" {
  value = "https://${module.cluster.cluster_endpoint}"
}

# -------------------- Instances  OUTPUT ------------------------
output "mongo_private_ip" {
  value = module.instance-mongo.0.instance_private_IP
}

output "mongo_public_ip" {
  value = module.instance-mongo.0.instance_public_IP
}

output "psql_private_ip" {
  value = module.postgres-14.ip_private_psql
}
# -------------------- Cluster  OUTPUT ------------------------
output "cluster_ca_certificate" {
  value = module.cluster.cluster_ca_certificate
  sensitive = true
}

output "client_certificate" {
  value = module.cluster.client_certificate
  sensitive = true
}

output "cluster_endpoint" {
  value = module.cluster.cluster_endpoint
}