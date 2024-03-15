variable "group_name" {}

variable "users" {
  type = list(string)
}

variable "databricks_client_id" {
  sensitive = true
}

variable "databricks_client_secret" {
  sensitive = true
}

variable "databricks_account_id" {}