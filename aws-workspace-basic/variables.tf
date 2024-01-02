variable "databricks_client_id" {
  sensitive = true
}

variable "databricks_client_secret" {
  sensitive = true
}
variable "databricks_account_id" {}

variable "workspace_name" {}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
  type = string
}