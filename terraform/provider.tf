terraform {
  backend "gcs" {
    bucket      = "gt-tfstate"
    prefix      = "terraform/state"
    credentials = "cisco-team-green.json"

    #    workspace_key_prefix = 12 # new # not ok
    #    encrypt              = true
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

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}