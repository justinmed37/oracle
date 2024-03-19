variable "compartment_id" {}
variable "vcn_id" {}
variable "prefix" {}
variable "cidr_block" {}
variable "dhcp_options_id" {}

resource "oci_core_subnet" "public" {
  display_name    = "${var.prefix}-subnet-public"
  cidr_block      = var.cidr_block
  compartment_id  = var.compartment_id
  vcn_id          = var.vcn_id
  dhcp_options_id = var.dhcp_options_id

  prohibit_internet_ingress = false
  route_table_id            = oci_core_route_table.route_table_public.id
  security_list_ids         = [oci_core_security_list.security_list_public.id]
}

resource "oci_core_route_table" "route_table_public" {
  display_name   = "${var.prefix}-route-table-public"
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id

  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway_public.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_route_table_attachment" "route_attach_public" {
  subnet_id      = oci_core_subnet.public.id
  route_table_id = oci_core_route_table.route_table_public.id
}

resource "oci_core_internet_gateway" "internet_gateway_public" {
  display_name   = "${var.prefix}-internet-gateway-public"
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  enabled        = true
}

resource "oci_core_security_list" "security_list_public" {
  display_name   = "${var.prefix}-security-list-public"
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id


  egress_security_rules {
    protocol         = "6"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    description      = "Enable all egress traffic from subnet"
  }

  ingress_security_rules {
    protocol    = "6"
    source_type = "CIDR_BLOCK"
    source      = "0.0.0.0/0"
    description = "Enable SSH traffic to public subnet"
    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source_type = "CIDR_BLOCK"
    source      = "0.0.0.0/0"
    description = "Enable SSH traffic to public subnet"
    tcp_options {
      max = "80"
      min = "80"
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source_type = "CIDR_BLOCK"
    source      = "0.0.0.0/0"
    description = "Enable SSH traffic to public subnet"
    tcp_options {
      max = "443"
      min = "443"
    }
  }

  ingress_security_rules {
    protocol    = "1"
    source_type = "CIDR_BLOCK"
    source      = "0.0.0.0/0"
    description = "ICMP"
    icmp_options {
      code = 3
      type = 4
    }
  }

  ingress_security_rules {
    protocol    = "1"
    source_type = "CIDR_BLOCK"
    source      = "0.0.0.0/0"
    description = "ICMP"
    icmp_options {
      type = 3
    }
  }
}