generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project     = "cisco-team-green"
  region      = "us-west1"
}
EOF
}

remote_state {
  #  backend = "local"
  backend = "gcs"
  config = {
    project = "cisco-team-green"
    bucket  = "gt-tfstate"
    prefix  = "terragrunt/${path_relative_to_include()}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}