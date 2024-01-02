variable "group_name" {}

variable "users" {
  type = list(string)
}

variable "databricks_client_id" {
}

variable "databricks_client_secret" {
}

variable "databricks_account_id" {}