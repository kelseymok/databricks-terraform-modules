variable "databricks_account_username" {}
variable "databricks_account_password" {}
variable "databricks_workspace_url" {}

#variable "region" {
#  type = string
#}

variable "team" {
  type = string
  default = "users"
}

variable "policy_overrides" {
  description = "Cluster policy overrides (JSON)"
  default = {}
}