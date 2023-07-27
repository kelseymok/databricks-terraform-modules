variable "group_name" {}

variable "users" {
  type = list(string)
}

variable "databricks_account_username" {}
variable "databricks_account_password" {}
variable "databricks_account_id" {}