variable "tenancy_id" {}
variable "compartment_id" {}
variable "vcn_prefix" {}
variable "cidr_block" {}
variable "public_cidr_block" {}
variable "private_cidr_block" {}

# Create the VCN
resource "oci_core_vcn" "generic_bu_vcn" {
  display_name   = "${var.vcn_prefix}network"
  compartment_id = var.compartment_id
  cidr_block     = var.cidr_block
}

# Create the public subnet
module "public_subnet" {
  source         = "../shared_modules/public_subnet"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.generic_bu_vcn.id
  prefix         = var.vcn_prefix
  cidr_block     = var.public_cidr_block
}
