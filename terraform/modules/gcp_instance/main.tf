# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
resource "google_compute_instance" "default" {
  name                = var.instance_name
  machine_type        = var.machine_type
  zone                = var.zone
  tags                = ["ssh", "schedule", "${terraform.workspace}"]
  count               = var.instance_count
  deletion_protection = var.delete_protection


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 12
      labels = {
        "author" : "vitaliy",
        "app" : "schedule",
        "environment" : "${terraform.workspace}",
        "type" : var.instance_name
      }
    }
  }

  lifecycle {
    ignore_changes  = [tags, ]
    prevent_destroy = false # destroy before changing some options
    # create_before_destroy = true
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y nano"
  metadata = {
    ssh-keys = "ubuntu: ${var.pub_key_ssh}"
  }
  network_interface {
    subnetwork = var.subnet_id
    # network_ip = (Optional) The private IP address to assign to the instance.

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}


