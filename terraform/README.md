## Implementation: Terraform for Google Cloud Infrastructure

<img src="../screenshots/tf-logo.png" alt="Terraform Logo" width="160" style="float: right; margin-left: 20px;"/>

### "Schedule" Project Structure:

The project is organized into several directories:

- **modules**: Contains reusable Terraform modules for creating:
  - VPC
  - Instances

- **workspace_vars**:
  - **dev/**: Configuration for the development environment.
  - **prod/**: Configuration for the production environment.
  - **stage/**: Configuration for the staging environment.

### Usage
- Genetate ssh key-pair for new instances (if needed) in the terraform directory  
- Add secret PG_PASSWORD to GCP Secret Manager (nedded for Postgres DB). This value will be given to GCP_Helm chart module.
- Add required variables to files `terraform/workspace_vars/prod.json`, example:
```text
{
  "env" : "prod",
  "gcp_project_id": "cisco-team-green",
  "zone": "us-west1-b",
  "region": "us-west1",
  "instance_count": 0,
  "cidr_range": "10.0.30.0/24"
}
```
- Modify resource Instance configurations in main.tf (for example):
```text
machine_type  = "e2-micro"      # 2 vCPU + 1 GB memory
machine_type  = "e2-medium"     # 2 vCPU + 4 GB memory
machine_type  = "e2-standard-2" # 2 vCPU + 8 GB memory
```
- Node Type for Kubernetes Cluster
```text 
node_machine_type   = "e2-small"
```

- Create local workspaces (prod, stage, dev) using commands:
```shell
terraform workspace new prod
```
- Switch between workspaces using commands:
```shell
terraform workspace list
terraform workspace select dev
```

To plan and apply changes using Terraform, navigate to the project directory and execute the following commands:

```shell
terraform plan -var-file=workspace_vars/dev.json
terraform apply -var-file=workspace_vars/dev.json
```

### Google Cloud CLI Setup

Before using Terraform, ensure you've authenticated via the Google Cloud CLI:

```shell
gcloud auth login
gcloud auth login --cred-file=cisco-team-green.json
gcloud config set project cisco-team-green
```

### IAM Configuration

Ensure that the following roles are assigned to the Terraform service account in the IAM section of the Google Cloud Console:

- Compute Network Admin
- Secret Manager Admin
- Editor


Example of directory structure with `credentials` and `id_rsa` keys:
```text
├── gcp_credentials.json
├── database_pg.tf
├── id_rsa
├── id_rsa.pub
├── kuber.tf
├── main.tf
├── Makefile
├── modules
├── gcp_instance
│   ├── main.tf
│   └── var.tf
├── gcp_network
│    ├── main.tf
│    ├── nat.tf
│    └── var.tf
├── provider.tf
├── README.md
├── var.tf
└── workspace_vars
    ├── dev.json
    ├── prod.json
    └── stage.json

```

-------------------------------------------------
### Usage with Makefile
This project includes a Makefile to simplify common Terraform tasks. The Makefile contains several targets to perform actions like initializing Terraform, planning changes, applying changes to different environments, destroying resources, and more. All available commands are in Makefile 


- Validate Terraform Configuration:
```shell
make validate
```