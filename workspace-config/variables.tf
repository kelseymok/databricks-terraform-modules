variable "databricks_client_id" {
}

variable "databricks_client_secret" {
}

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