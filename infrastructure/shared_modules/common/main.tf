
locals {
  tenancy_id       = "ocid1.tenancy.oc1..aaaaaaaaiutrjzaumegnunzwoqhngqcwnewh2ptjd4jqhqk6ovs47uqlso3a"
  compartment_name = "generic_bu"
  prefix           = "generic-bu"
}

data "oci_identity_compartments" "root" {
  compartment_id            = local.tenancy_id
  name                      = local.compartment_name
  compartment_id_in_subtree = true
}

output "data" {
  value = {
    tenancy_id       = local.tenancy_id
    compartment_name = local.compartment_name
    prefix           = local.prefix
    compartment_id   = data.oci_identity_compartments.root.compartments[0].id
  }
}