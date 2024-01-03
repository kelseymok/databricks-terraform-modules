// initialize provider at workspace level, to create UC resources
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = ">=1.33.0"
      configuration_aliases = [ databricks.workspace ]
    }
  }
}