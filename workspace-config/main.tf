resource "databricks_workspace_conf" "this" {
  provider = databricks.workspace
  custom_config = {
    #    "enableWebTerminal" : true,
    #    "enableGp3" : true,
    "enableDbfsFileBrowser": true, // This seems to not work, not sure why: https://<workspace URL>.cloud.databricks.com/config
    #    "enableDcs" : true
  }
}