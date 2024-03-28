module "common" {
  source = "../"
}

data "oci_database_autonomous_databases" "db" {
  compartment_id = module.common.data.compartment_id
}

output "data" {
  value = data.oci_database_autonomous_databases.db.autonomous_databases
}