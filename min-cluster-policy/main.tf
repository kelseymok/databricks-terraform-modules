variable "team" {}

variable "policy_overrides" {
  description = "Cluster policy overrides"
}

locals {
  default_policy = {
    "node_type_id": {
      "type": "allowlist",
      "values": [
        "i3en.large"
      ],
      "defaultValue": "i3en.large"
    },
    "driver_node_type_id": {
      "type": "fixed",
      "value": "i3en.large",
      "hidden": false
    },
    "autoscale.min_workers": {
      "type": "fixed",
      "value": 1,
      "hidden": false
    },
    "autoscale.max_workers": {
      "type": "fixed",
      "value": 2,
      "hidden": false
    },
    "enable_elastic_disk": {
      "type": "fixed",
      "value": false,
      "hidden": false
    },
    "autotermination_minutes": {
      "type": "fixed",
      "value": 30,
      "hidden": false
    },
    "spark_conf.spark.databricks.cluster.profile": {
      "isOptional": true,
      "type": "unlimited",
      "hidden": true
    },
    "data_security_mode": "NONE"
  }
}

resource "databricks_cluster_policy" "fair_use" {
  name       = "Min cluster policy"
  definition = jsonencode(merge(local.default_policy, var.policy_overrides))
}

resource "databricks_permissions" "can_use_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.fair_use.id
  access_control {
    group_name       = var.team
    permission_level = "CAN_USE"
  }
}