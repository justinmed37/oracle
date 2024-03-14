variable tenancy_ocid {
    default = "ocid1.tenancy.oc1..aaaaaaaaiutrjzaumegnunzwoqhngqcwnewh2ptjd4jqhqk6ovs47uqlso3a"
}

resource oci_identity_compartment projectX {
    #Required
    compartment_id = var.tenancy_ocid
    description = "projectX compartment"
    name = "projectX"
}