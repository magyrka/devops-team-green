terraform {
  backend "gcs" {
    bucket      = "gt-tfstate"
    prefix      = "terraform/state"
    credentials = "cisco-team-green.json"
  }

  required_providers {
    # https://github.com/hashicorp/terraform-provider-google/releases
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_json)
  project     = var.gcp_project_id
  region      = var.region
  zone        = var.zone
}