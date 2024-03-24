variable "tenancy_id" {}
variable "compartment_id" {}
variable "vcn_prefix" {}
variable "cidr_block" {}
variable "public_cidr_block" {}
variable "private_cidr_block" {}
variable "dns_label" {}

# Create the VCN
resource "oci_core_vcn" "generic_bu_vcn" {
  display_name   = "${var.vcn_prefix}-network"
  compartment_id = var.compartment_id
  cidr_block     = var.cidr_block
  dns_label      = var.dns_label
}

# Create the public subnet
module "public_subnet" {
  source          = "../shared_modules/public_subnet"
  compartment_id  = var.compartment_id
  vcn_id          = oci_core_vcn.generic_bu_vcn.id
  prefix          = var.vcn_prefix
  cidr_block      = var.public_cidr_block
  dhcp_options_id = oci_core_dhcp_options.dhcp_options.id
}

# Create the private subnet
module "private" {
  source             = "../shared_modules/private_subnet"
  compartment_id     = var.compartment_id
  vcn_id             = oci_core_vcn.generic_bu_vcn.id
  prefix             = var.vcn_prefix
  cidr_block         = var.private_cidr_block
  ingress_cidr_block = var.cidr_block
  dhcp_options_id    = oci_core_dhcp_options.dhcp_options.id
}

resource "oci_core_dhcp_options" "dhcp_options" {
  display_name   = "${var.vcn_prefix}-dhcp-options"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.generic_bu_vcn.id
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["genericbunetwork.oraclevcn.com"]
  }
}