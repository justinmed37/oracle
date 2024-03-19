variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaaiutrjzaumegnunzwoqhngqcwnewh2ptjd4jqhqk6ovs47uqlso3a"
}

resource "oci_identity_compartment" "projectX" {
  # Required
  compartment_id = var.tenancy_ocid
  description    = "projectX compartment"
  name           = "projectX"
}

# resource "oci_objectstorage_bucket" "tfstate" {
#   # Required
#   compartment_id = resource.oci_identity_compartment.projectX.id
#   name           = "tfstate"
#   namespace      = "idbjyurhyjpo"

#   # Optional
#   versioning = "Enabled"
# }

resource "oci_objectstorage_bucket" "bootstrap_tfstate" {
  # Required
  compartment_id = var.tenancy_ocid
  name           = "bootstrap_tfstate"
  namespace      = "idbjyurhyjpo"

  # Optional
  versioning = "Enabled"
}

resource "oci_identity_compartment" "generic_bu" {
  # Required
  compartment_id = var.tenancy_ocid
  description    = "Compartment for generic business unit"
  name           = "generic_bu"
}

resource "oci_objectstorage_bucket" "generic_bu" {
  # Required
  compartment_id = resource.oci_identity_compartment.generic_bu.id
  name           = "generic_bu_tfstate"
  namespace      = "idbjyurhyjpo"

  # Optional
  versioning = "Enabled"
}