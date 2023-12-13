
output "subnet_1_id" {
  value = google_compute_subnetwork.private[0].id
}

output "google_compute_network_ID" {
  value = google_compute_network.vpc_network.id
}

output "private_vpc_con" {
  value = google_service_networking_connection.private_vpc_connection
}

