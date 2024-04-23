// https://registry.terraform.io/providers/databricks/databricks/latest/docs#special-configuration-for-unity-catalog
// Except for metastore, metastore assignment and storage credential objects, Unity Catalog APIs are accessible
// via workspace-level APIs. This design may change in the future.
//
// NOTE: This is frustrating because it means we need to stand up a workspace before creating the Unity Catalog and
// then that first workspace is hardcoded into the terraform provider for the workspace. Creates a strange dependency.

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

resource "databricks_grants" "this" {
  provider     = databricks.workspace
  metastore = databricks_metastore.this.id
  grant {
    principal  = "account users"
    privileges = ["CREATE_CATALOG"]
  }
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

resource "databricks_catalog" "sandbox" {
  provider             = databricks.workspace
  metastore_id = databricks_metastore.this.id
  name         = "sandbox"
  comment      = "This catalog is managed by Terraform"
  properties = {
    purpose = "Training"
  }
  depends_on = [databricks_metastore_assignment.default_metastore]
}

resource "databricks_grants" "sandbox" {
  provider = databricks.workspace
  catalog = databricks_catalog.sandbox.name

  grant {
    principal  = "account users"
    privileges = [
      "ALL_PRIVILEGES",
    ]
  }
}

resource "databricks_catalog" "dbdemos" {
  provider             = databricks.workspace
  metastore_id = databricks_metastore.this.id
  name         = "dbdemos"
  comment      = "This catalog is managed by Terraform"
  properties = {
    purpose = "Training"
  }
  depends_on = [databricks_metastore_assignment.default_metastore]
}


resource "databricks_grants" "dbdemos" {
  provider = databricks.workspace
  catalog = databricks_catalog.dbdemos.name

  grant {
    principal  = "account users"
    privileges = [
      "ALL_PRIVILEGES",
    ]
  }
}

data "databricks_mws_workspaces" "all" {
  provider = databricks.mws
}

output "all_workspace_ids" {
  value = local.all_workspace_ids
}