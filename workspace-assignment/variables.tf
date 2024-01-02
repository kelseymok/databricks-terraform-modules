
variable "permission_level" {
  description = "Must be 'admin' or 'user'"
}

variable "workspace_id" {
  type = string
}

variable "group_id" {
  type = string
}

variable "databricks_client_id" {
  sensitive = true
}

variable "databricks_client_secret" {
  sensitive = true
}

variable "databricks_account_id" {}