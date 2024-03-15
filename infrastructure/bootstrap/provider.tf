provider "oci" {
  tenancy_ocid        = var.tenancy_ocid
}

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "3.74.0"
#     }
#   }
# }