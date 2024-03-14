variable "config_file_profile" {}

provider "oci" {
  tenancy_ocid        = var.tenancy_ocid
  config_file_profile = "DEFAULT"
}