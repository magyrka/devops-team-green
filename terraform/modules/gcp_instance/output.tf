output "instance_public_IP" {
  #  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#network_interface.0.access_config.0.nat_ip
  value = google_compute_instance.default[0].network_interface.0.access_config.0.nat_ip
  #    value = google_compute_instance.default.ip
}

output "instance_private_IP" {
  value = google_compute_instance.default[0].network_interface.0.network_ip
  #  value = google_compute_instance.default.ip
}
