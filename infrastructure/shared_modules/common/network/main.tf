
locals {
  tenancy_id       = "ocid1.tenancy.oc1..aaaaaaaaiutrjzaumegnunzwoqhngqcwnewh2ptjd4jqhqk6ovs47uqlso3a"
  compartment_name = "generic_bu"
  prefix           = "generic-bu"
  compartment_id   = data.oci_identity_compartments.root.compartments[0].id
  vcn_id           = data.oci_core_vcns.vcn.virtual_networks[0].id
}

data "oci_identity_compartments" "root" {
  compartment_id            = local.tenancy_id
  name                      = local.compartment_name
  compartment_id_in_subtree = true
}

data "oci_core_vcns" "vcn" {
  compartment_id = local.compartment_id
  display_name   = "${local.prefix}-network"
}

data "oci_core_subnets" "subnet_public" {
  compartment_id = local.compartment_id
  display_name   = "${local.prefix}-subnet-public"
  vcn_id         = local.vcn_id
}

data "oci_core_subnets" "subnets" {
  compartment_id = local.compartment_id
  vcn_id         = local.vcn_id
}

data "oci_core_network_security_groups" "nsg" {
  compartment_id = local.compartment_id
  vcn_id         = data.oci_core_vcns.vcn.virtual_networks[0].id
}

locals {
  output_data = {
    tenancy_id = local.tenancy_id
    compartment_id = data.oci_identity_compartments.root.compartments[0].id
    vcn = data.oci_core_vcns.vcn.virtual_networks[0]
    subnets = data.oci_core_subnets.subnets.subnets
    nsgs = data.oci_core_network_security_groups.nsg.network_security_groups
  }
}

output "data_model" {
  value = local.output_data
}


# Old outputs
output "tenancy_id" {
  value = local.tenancy_id
}

output "compartment_id" {
  value = data.oci_identity_compartments.root.compartments[0].id
}

output "vcn_id" {
  value = data.oci_core_vcns.vcn.virtual_networks[0].id
}

output "public_subnet_id" {
  value = data.oci_core_subnets.subnet_public.subnets[0].id
}

output "nsg_id" {
  value = data.oci_core_network_security_groups.nsg.network_security_groups[0].id
}