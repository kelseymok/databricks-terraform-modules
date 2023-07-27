locals {
  permission_level_mapping = {
    "user" = "USER",
    "admin" = "ADMIN"
  }
}

resource "databricks_mws_permission_assignment" "this" {
  provider = databricks.mws
  workspace_id = var.workspace_id
  principal_id = var.group_id //databricks_group.this.id
  permissions  = [lookup(local.permission_level_mapping, var.permission_level)]
}
