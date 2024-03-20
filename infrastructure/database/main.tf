variable "tenancy_ocid" {}
variable "compartment_id" {}
variable "admin_password" {}
variable "db_name" {}
variable "whitelisted_ips" {}

resource "oci_database_autonomous_database" "oci_database_autonomous_database" {
  admin_password                       = var.admin_password
  autonomous_maintenance_schedule_type = "REGULAR"
  compartment_id                       = var.compartment_id
  compute_count                        = "2"
  compute_model                        = "ECPU"
  customer_contacts {
    email = "justinmed37@gmail.com"
  }
  data_storage_size_in_gb                        = "128"
  db_name                                        = var.db_name
  db_version                                     = "21c"
  db_workload                                    = "AJD"
  display_name                                   = "generic-bu-auto-db"
  is_auto_scaling_enabled                        = "false"
  is_auto_scaling_for_storage_enabled            = "false"
  is_dedicated                                   = "false"
  is_free_tier                                   = "true"
  is_mtls_connection_required                    = "true"
  is_preview_version_with_service_terms_accepted = "false"
  license_model                                  = "LICENSE_INCLUDED"
  whitelisted_ips                                = var.whitelisted_ips
}
