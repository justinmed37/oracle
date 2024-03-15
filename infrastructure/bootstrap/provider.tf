variable "config_file_profile" {}

provider "oci" {
  tenancy_ocid        = var.tenancy_ocid
  config_file_profile = "DEFAULT"
}

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "3.74.0"
#     }
#   }
# }