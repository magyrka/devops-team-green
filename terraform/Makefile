init:
	terraform init

validate:
	terraform fmt -recursive
	terraform validate

plan-dev:
	terraform workspace select dev
	terraform plan -var-file=workspace_vars/dev.json

apply-dev:
	terraform workspace select dev
	terraform apply -var-file=workspace_vars/dev.json

plan-stage:
	terraform workspace select stage
	terraform plan -var-file=workspace_vars/stage.json

apply-stage:
	terraform workspace select stage
	terraform apply -var-file=workspace_vars/stage.json

plan-prod:
	terraform workspace select prod
	terraform plan -var-file=workspace_vars/prod.json

apply-prod:
	terraform workspace select prod
	terraform apply -var-file=workspace_vars/prod.json

destroy-dev:
	terraform workspace select dev
	terraform destroy -var-file=workspace_vars/dev.json

destroy-stage:
	terraform workspace select stage
	terraform destroy -var-file=workspace_vars/stage.json

destroy-prod:
	terraform workspace select prod
	terraform destroy -var-file=workspace_vars/prod.json

plan-all: validate plan-dev plan-prod plan-stage