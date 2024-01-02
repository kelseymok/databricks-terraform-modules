resource "databricks_workspace_conf" "this" {
  provider = databricks.workspace
  custom_config = {
    "enableDbfsFileBrowser": true,
    "enableTokensConfig": true,
#    "enablePersonalVMPolicyForAllUsers": false // TODO: https://github.com/databricks/terraform-provider-databricks/issues/2534
  }
}