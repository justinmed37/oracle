

# locals {
#   tenancy_id       = "ocid1.tenancy.oc1..aaaaaaaaiutrjzaumegnunzwoqhngqcwnewh2ptjd4jqhqk6ovs47uqlso3a"
#   compartment_name = "generic_bu"
#   prefix           = "generic-bu"
#   compartment_id   = data.oci_identity_compartments.root.compartments[0].id
# }

# data "oci_identity_compartments" "root" {
#   compartment_id            = local.tenancy_id
#   name                      = local.compartment_name
#   compartment_id_in_subtree = true
# }

module "common" {
  source = "../"
}



data "oci_container_instances_container_instances" "instances" {
  compartment_id = module.common.data.compartment_id
  display_name   = "${module.common.data.compartment_name}-container-instance-frontend" # TODO: fix container naming scheme
}

output "data" {
  value = data.oci_container_instances_container_instances.instances.container_instance_collection
}