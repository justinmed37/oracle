variable "compartment_id" {}
variable "vcn_id" {}
variable "prefix" {}
variable "cidr_block" {}
variable "dhcp_options_id" {}
variable "ingress_cidr_block" {}

resource "oci_core_subnet" "private" {
  display_name              = "${var.prefix}-subnet-private"
  cidr_block                = var.cidr_block
  compartment_id            = var.compartment_id
  vcn_id                    = var.vcn_id
  dhcp_options_id           = var.dhcp_options_id
  prohibit_internet_ingress = false
  route_table_id            = oci_core_route_table.route_table_private.id
  security_list_ids         = [oci_core_security_list.security_list_private.id]
}


resource "oci_core_route_table" "route_table_private" {
  display_name   = "${var.prefix}-route-table-private"
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id

#   route_rules {
#     network_entity_id = oci_core_nat_gateway.nat_gateway_private.id
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR"
#   }

  route_rules {
    network_entity_id = oci_core_service_gateway.service_gateway_private.id
    destination_type  = "SERVICE_CIDR_BLOCK"
    destination = "all-iad-services-in-oracle-services-network"
  }
}

resource "oci_core_nat_gateway" "nat_gateway_private" {
  display_name   = "${var.prefix}-nat-gateway-private"
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  # route_table_id = oci_core_route_table.route_table_private.id
  block_traffic  = true
  # public_ip_id = oci_core_public_ip.test_public_ip.id
}

data "oci_core_services" "all" {}

resource "oci_core_service_gateway" "service_gateway_private" {
  display_name   = "${var.prefix}-service-gateway-private"
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  # route_table_id = oci_core_route_table.route_table_private.id

  services {
    service_id = data.oci_core_services.all.services.0.id
  }
}

resource "oci_core_route_table_attachment" "route_attach_private" {
  subnet_id      = oci_core_subnet.private.id
  route_table_id = oci_core_route_table.route_table_private.id
}

# resource "oci_core_internet_gateway" "internet_gateway_private" {
#   display_name   = "${var.prefix}-internet-gateway-private"
#   compartment_id = var.compartment_id
#   vcn_id         = var.vcn_id
#   enabled        = true
# }

resource "oci_core_security_list" "security_list_private" {
  display_name   = "${var.prefix}-security-list-private"
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
    source      = var.ingress_cidr_block
    description = "Enable private SSH traffic to private subnet"
    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source_type = "CIDR_BLOCK"
    source      = var.ingress_cidr_block
    description = "Enable private TCP HTTP traffic to private subnet"
    tcp_options {
      max = "80"
      min = "80"
    }
  }

  ingress_security_rules {
    protocol    = "6"
    source_type = "CIDR_BLOCK"
    source      = var.ingress_cidr_block
    description = "Enable private TCP HTTPS traffic to private subnet"
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
    source      = var.ingress_cidr_block
    description = "ICMP"
    icmp_options {
      type = 3
    }
  }
}
