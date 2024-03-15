resource "databricks_group" "this" {
  provider       = databricks.workspace
  display_name               = var.group_name
  allow_cluster_create       = false
  allow_instance_pool_create = false
  workspace_access           = true
  databricks_sql_access      = true
}

#resource "databricks_user" "this" {
#  for_each = toset(var.users)
#  user_name = each.key
#}

data "databricks_user" "this" {
  provider = databricks.workspace
  for_each = toset(var.users)
  user_name = each.key
}

resource "databricks_group_member" "this" {
  provider = databricks.workspace
  for_each = data.databricks_user.this
  group_id  = databricks_group.this.id
  member_id = each.value["id"]
}

output "debug" {
  value = data.databricks_user.this
}