
Install Terraform 
Install terragrunt 
https://terragrunt.gruntwork.io/docs/getting-started/install/
or:
```shell
sudo snap install terragrunt
```
Best way is to use binary file

#### Install the [ gcloud CLI](https://cloud.google.com/sdk/docs/install#deb)
```shell
sudo apt-get update
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
```

#### Login to GCP locally 
```shell
gcloud auth login
gcloud auth login --cred-file=cisco-team-green.json
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/cisco-team-green.json"
```

- init terragrunt inside dev/  directory
```shell
terragrunt run-all init
```

- plan terragrunt inside dev/  directory
```shell
terragrunt run-all plan
```


Formatting hcl files ( at the root)
```shell
terragrunt hclfmt
```