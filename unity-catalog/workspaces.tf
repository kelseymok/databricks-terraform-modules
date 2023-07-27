resource "databricks_metastore" "this" {
  provider      = databricks.workspace
  name          = "primary"
  storage_root  = "s3://${aws_s3_bucket.metastore.id}/metastore"
  owner         = var.unity_admin_group
  force_destroy = true
}

resource "databricks_metastore_data_access" "this" {
  provider     = databricks.workspace
  metastore_id = databricks_metastore.this.id
  name         = aws_iam_role.metastore_data_access.name
  aws_iam_role {
    role_arn = aws_iam_role.metastore_data_access.arn
  }
  is_default = true
}

locals {
  all_workspace_ids_generated = data.databricks_mws_workspaces.all.ids == null ? {} : data.databricks_mws_workspaces.all.ids
  all_workspace_ids =  length(var.workspace_ids_override) > 0 ? var.workspace_ids_override : [for i in values(local.all_workspace_ids_generated) : tostring(i)]
}

resource "databricks_metastore_assignment" "default_metastore" {
  provider             = databricks.workspace
  for_each             = toset(local.all_workspace_ids)
#  for_each             = toset(var.databricks_workspace_ids)
  workspace_id         = each.key
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"
}

data "databricks_mws_workspaces" "all" {
  provider = databricks.mws
}

output "all_workspace_ids" {
  value = local.all_workspace_ids
}