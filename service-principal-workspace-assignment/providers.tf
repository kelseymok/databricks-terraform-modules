provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  client_id = var.databricks_client_id
  client_secret = var.databricks_client_secret
}

provider "databricks" {
  alias    = "workspace"
  host     = var.databricks_workspace_url
  account_id = var.databricks_account_id
  client_id = var.databricks_client_id
  client_secret = var.databricks_client_secret
}