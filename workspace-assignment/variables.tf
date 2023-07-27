
variable "permission_level" {
  description = "Must be 'admin' or 'user'"
}

variable "workspace_id" {
  type = string
}

variable "group_id" {
  type = string
}

variable "databricks_account_username" {}
variable "databricks_account_password" {}
variable "databricks_account_id" {}