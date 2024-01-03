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

// Allows the Service Principal to use PAT (managing OAuth)
// https://docs.databricks.com/en/dev-tools/service-principals.html#step-3-assign-workspace-level-permissions-to-the-databricks-service-principal
resource "databricks_permissions" "token_usage" {
  provider = databricks.workspace
  authorization = "tokens"

  access_control {
    service_principal_name = data.databricks_service_principal.this.application_id
    permission_level = "CAN_USE"
  }
}
