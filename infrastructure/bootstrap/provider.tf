terraform {
  required_version = ">= 1.7.4"
  required_providers {
    oci = {
      version = ">= 4.44.0 "
      source = "oracle/oci"
    }
  }
}
# provider "oci" {
#   tenancy_ocid        = var.tenancy_ocid
#   config_file_profile = "DEFAULT"
# }

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "3.74.0"
#     }
#   }
# }