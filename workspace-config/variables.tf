variable "databricks_client_id" {
  sensitive = true
}

variable "databricks_client_secret" {
  sensitive = true
}

variable "databricks_workspace_url" {}

variable "databricks_account_id" {}

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