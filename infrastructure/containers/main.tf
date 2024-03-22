variable "tenancy_ocid" {}
variable "compartment_id" {}
variable "compartment_name" {}
variable "prefix" {}

locals {
  group_name = oci_identity_dynamic_group.container_repo.name
}
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
  statements = [
    "Allow dynamic-group ${local.group_name} to read repos in compartment ${var.compartment_name}",
    "Allow dynamic-group ${local.group_name} to read buckets in compartment ${var.compartment_name}",
    "Allow dynamic-group ${local.group_name} to read objects in compartment ${var.compartment_name}"
  ]
}

resource "oci_artifacts_container_repository" "generic_frontend" {
  display_name   = "generic-bu/frontend"
  compartment_id = var.compartment_id
  is_immutable   = false
  is_public      = false
}

data "oci_identity_availability_domains" "local_ads" {

  compartment_id = var.compartment_id
}

module "common" {
  source = "../shared_modules/common/network"
}

resource "oci_container_instances_container_instance" "frontend" {
  #Required
  display_name        = "${var.prefix}-container-instance-frontend"
  availability_domain = data.oci_identity_availability_domains.local_ads.availability_domains.0.name
  compartment_id      = module.common.compartment_id
  shape               = "CI.Standard.E4.Flex"
  shape_config {
    ocpus         = 1
    memory_in_gbs = 4
  }
  vnics {
    subnet_id             = module.common.public_subnet_id
    is_public_ip_assigned = true
    nsg_ids               = [module.common.nsg_id]
  }
  containers {
    image_url                      = "iad.ocir.io/idbjyurhyjpo/generic-bu/frontend:1-6-dev"
    is_resource_principal_disabled = false
    working_directory              = "/app/frontend"
    command                        = ["./start.sh"]
    environment_variables          = { "DB_USER" : "ADMIN", "HTTP_PORT" : "443" }
    # arguments                      = ["main.py"]
    resource_config {
      memory_limit_in_gbs = 4
      vcpus_limit         = 1
    }
  }
}

# Bucket for certificates
resource "oci_objectstorage_bucket" "generic_bu" {
  compartment_id = module.common.compartment_id
  name           = "certificates"
  namespace      = "idbjyurhyjpo"
  versioning     = "Enabled"
}