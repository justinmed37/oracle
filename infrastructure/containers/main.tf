variable "tenancy_ocid" {}
variable "compartment_id" {}
variable "compartment_name" {}
variable "prefix" {}


# Dynamic group that will be used for identity policy
resource "oci_identity_dynamic_group" "container_repo" {
  name           = "generic-bu-container-repo"
  compartment_id = var.tenancy_ocid
  description    = "Dynamic group for container registry authentication"
  matching_rule  = "ALL {resource.type='computecontainerinstance'}"
}

resource "oci_identity_policy" "container_repo" {
  name           = "generic-bu-container-repo"
  compartment_id = var.tenancy_ocid
  description    = "Policy to allow generic-bu-containers to authenticate"
  statements     = ["Allow dynamic-group ${oci_identity_dynamic_group.container_repo.name} to read repos in compartment ${var.compartment_name}"]
}

resource "oci_artifacts_container_repository" "generic_frontend" {
  display_name   = "generic-bu/frontend"
  compartment_id = var.compartment_id
  is_immutable   = false
  is_public      = false
}