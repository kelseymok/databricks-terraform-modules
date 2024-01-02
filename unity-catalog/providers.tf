provider "aws" {
  region = var.region
}

// initialize provider in "MWS" mode for account-level resources
provider "databricks" {
  alias      = "mws"
  host       = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  client_id = var.databricks_client_id
  client_secret = var.databricks_client_secret
}

// initialize provider at workspace level, to create UC resources
provider "databricks" {
  alias    = "workspace"
  host     = var.databricks_workspace_url
  client_id = var.databricks_client_id
  client_secret = var.databricks_client_secret
}