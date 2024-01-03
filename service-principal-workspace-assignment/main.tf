data "databricks_service_principal" "this" {
  provider = databricks.mws
  application_id = var.databricks_client_id
}

// Add Databricks Service Principal to the Databricks Workspace
// https://docs.databricks.com/en/dev-tools/service-principals.html#step-2-add-the-databricks-service-principal-to-your-databricks-workspace
resource "databricks_mws_permission_assignment" "this" {
  provider = databricks.mws
  workspace_id = var.workspace_id
  principal_id = data.databricks_service_principal.this.id
  permissions  = ["ADMIN"]
}


data "databricks_group" "admins" {
  provider = databricks.workspace
  display_name = "admins"
}

// Allows the Service Principal to use PAT (managing OAuth)
// https://docs.databricks.com/en/dev-tools/service-principals.html#step-3-assign-workspace-level-permissions-to-the-databricks-service-principal
resource "databricks_permissions" "token_usage" {
  provider = databricks.workspace
  authorization = "tokens"

  access_control {
    service_principal_name = data.databricks_service_principal.this.application_id
    permission_level = "CAN_USE"
  }

  access_control {
    group_name = data.databricks_group.admins.display_name
    permission_level = "CAN_MANAGE"
  }


}
