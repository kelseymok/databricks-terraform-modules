# Databricks E2
This repository contains some terraform modules to create Databricks resources. To be used in other personal projects.

## Quickstart
1. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. AWS creds in your shell
3. Databricks creds in the shell
* TF_VAR_databricks_client_id, set to the value of your Databricks service principal id.
* TF_VAR_databricks_client_secret, set to the value of the secret for the service principal id.
* TF_VAR_databricks_account_id, set to the value of the ID of your Databricks account. You can find this value in the corner of your Databricks account console.