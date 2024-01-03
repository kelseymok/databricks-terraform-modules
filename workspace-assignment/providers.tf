terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=1.13.0"
      configuration_aliases = [aws]
    }
    databricks = {
      source = "databricks/databricks"
      version = ">=1.33.0"
      configuration_aliases = [ databricks.mws ]
    }
  }
}