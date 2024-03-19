terraform {
  required_version = ">= 1.7.4"
  required_providers {
    oci = {
      version = ">= 4.44.0 "
      source  = "oracle/oci"
    }
  }
}