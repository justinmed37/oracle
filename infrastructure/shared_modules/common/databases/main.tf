module "common" {
  source = "../"
}

data "oci_database_autonomous_databases" "db" {
  compartment_id = module.common.data.compartment_id
}

output "data" {
  value = data.oci_database_autonomous_databases.db.autonomous_databases
}

terraform {
  required_version = ">= 1.7.4"
  required_providers {
    oci = {
      version = "5.35.0"
      source  = "oracle/oci"
    }
  }
}