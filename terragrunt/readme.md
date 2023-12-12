[![Terragrunt](https://github.com/DTG-cisco/devops-team-green-2/actions/workflows/terragrant.yml/badge.svg?branch=main)](https://github.com/DTG-cisco/devops-team-green-2/actions/workflows/terragrant.yml)
## Custom Terraform Modules

---------------------------
### Description

This project relies on custom Terraform modules located within the `terraform/modules` directory. These modules have been specifically designed to enhance the deployment and management of various infrastructure components, ensuring modularity and efficiency in handling resources within the environment.

---------------------------

### Prerequisites
#### Before proceeding, ensure the following software is installed:

- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) 
- [Terraform](https://developer.hashicorp.com/terraform/install)

Installation via Snap (Terragrunt)
```shell
sudo snap install terragrunt
```
For optimal usage, consider installing Terragrunt via binary files.

#### Install the [ gcloud CLI](https://cloud.google.com/sdk/docs/install#deb)
```shell
sudo apt-get update
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli
```

#### Login to GCP locally 
```shell
gcloud auth login
gcloud auth login --cred-file=cisco-team-green.json
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/your-gcp-credentials.json"
```

[Inastall](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke) Kubectl authentication plugin 
```shell
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
```
---------------------------
### Usage
- Initialize Terragrunt inside the `terragrunt/` directory:
```shell
terragrunt run-all init
```

- Plan changes using Terragrunt inside the `terragrunt/` directory:
```shell
terragrunt run-all plan
```

- Apply Terragrunt changes inside the dev/ directory:
```shell
terragrunt run-all apply
```

### Formatting HCL Files
For consistent HCL (HashiCorp Configuration Language) formatting across your project, execute the following command at the root:
```shell
terragrunt hclfmt
```

----------------------
How to pass [environment variable ](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_env)
```text
get_env(NAME, DEFAULT)
remote_state {
  backend = "s3"
  config = {
    bucket = get_env("BUCKET")
  }
}
```

```text
{
      name  = "backend_image.tag"
#      https://developer.hashicorp.com/terraform/language/expressions/conditionals
      value = var.DOCKER_DEV_IMAGE_VERSION != "" ? var.DOCKER_DEV_IMAGE_VERSION : "latest"
},
```

```shell
tg run-all plan -var DOCKER_DEV_IMAGE_VERSION=0.1.2
```