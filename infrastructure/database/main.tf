variable "admin_password" {}
variable "db_name" {}

# Import data resources from common
module "common" {
  source = "../shared_modules/common/network"
}

# Network Security Group rule belongs here with the database infrastructure
resource "oci_core_network_security_group_security_rule" "nsg_security_rule" {
  network_security_group_id = module.common.nsg_id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.1.0/24"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = "1521"
      min = "1521"
    }
  }
}

# Create a private database in the public subnet that's accessible from the VCN
resource "oci_database_autonomous_database" "oci_database_autonomous_database" {
  display_name                                   = "generic-bu-auto-db"
  admin_password                                 = var.admin_password
  subnet_id                                      = module.common.public_subnet_id
  nsg_ids                                        = [module.common.nsg_id]
  autonomous_maintenance_schedule_type           = "REGULAR"
  compartment_id                                 = module.common.compartment_id
  compute_count                                  = "2"
  compute_model                                  = "ECPU"
  data_storage_size_in_gb                        = "20"
  db_name                                        = var.db_name
  db_version                                     = "19c"
  db_workload                                    = "AJD"
  is_auto_scaling_enabled                        = "false"
  is_auto_scaling_for_storage_enabled            = "false"
  is_dedicated                                   = "false"
  is_mtls_connection_required                    = "false"
  is_preview_version_with_service_terms_accepted = "false"
  license_model                                  = "LICENSE_INCLUDED"
  customer_contacts {
    email = "justinmed37@gmail.com"
  }
}