include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/DTG-cisco/devops-team-green-2.git//terraform/modules/gcp_secrets"
}
