

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