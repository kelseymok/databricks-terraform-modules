variable "workspace_id" {}

variable "databricks_client_id" {
  sensitive = true
}

variable "databricks_client_secret" {
  sensitive = true
}

variable "databricks_account_id" {}

variable "databricks_workspace_url" {}