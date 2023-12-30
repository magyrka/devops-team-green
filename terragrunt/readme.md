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

### Destroy specific resource 
Delete only one, for example Kubernetes Cluster 
```shell
cd /terragrunt/dev/kubernetes
terragrunt destroy target=kubernetes
```

You will be asked about dependencies:
```text
Detected dependent modules:
/terragrunt/dev/helm_app
/terragrunt/dev/helm_consol
/terragrunt/dev/kuber_namespaces
```
----------------------
How to pass [environment variable ](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_env) for example frontend image tag:
```text
get_env(NAME, DEFAULT)
{
   name  = "frontend_image.tag"
   value = get_env("FR_IMAGE_DEV_TAG", "${local.fe_img_tag}")
}
```

```shell
terragrunt run-all plan -var FR_IMAGE_DEV_TAG=1.0.1
```
here list of variables for Docker image Tags:
- Environment Dev:
  - BE_IMAGE_DEV_TAG
  - FR_IMAGE_DEV_TAG
- Environment Stage:
  - BE_IMAGE_STAGE_TAG
  - FR_IMAGE_STAGE_TAG
https://developer.hashicorp.com/consul/docs/k8s/helm

-------------------------
## Consul for Kubernetes

This repository facilitates the installation of Consul within our Kubernetes cluster using Terragrunt. 
The installation is managed via the `helm_consul` module, utilizing the Helm chart sourced from HashiCorp's Consul for Kubernetes repository.

### Installation Steps:
- Terragrunt Setup:
Ensure Terragrunt is installed and configured properly. 
- Deploy Consul:
Use Terragrunt to deploy Consul to your Kubernetes cluster.
- Helm [Chart Source](https://github.com/hashicorp/consul-k8s) :
The Helm chart used for Consul installation is retrieved from HashiCorp's Consul for Kubernetes repository. 
For detailed configuration options and chart specifics, refer to the Helm chart documentation provided in the repository.


