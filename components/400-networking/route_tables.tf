# Route Tables
resource "oci_core_route_table" "public_web" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "route-table-public-web"

  route_rules {

    network_entity_id = oci_core_internet_gateway.web.id

    description      = "Route to the Internet Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  # route_rules {

  #   network_entity_id = oci_core_drg.web.id

  #   description      = "Route to the web VCN (VCN Peering to GAIA)"
  #   destination      = "10.15.0.0/16"
  #   destination_type = "CIDR_BLOCK"
  # }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_mgmt" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "route-table-private-mgmt-01"


  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.web_01.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to web compute 01"
      destination      = format("%s/32", route_rules.value["ip_address"])
      destination_type = "CIDR_BLOCK"
    }
  }

  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.web_02.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to web compute 02"
      destination      = format("%s/32", route_rules.value["ip_address"])
      destination_type = "CIDR_BLOCK"
    }
  }

  freeform_tags = local.tags.defaults
}


# Route Table Attachments
resource "oci_core_route_table_attachment" "public_web" {
  subnet_id      = oci_core_subnet.public_web.id
  route_table_id = oci_core_route_table.public_web.id
}

resource "oci_core_route_table_attachment" "private_mgmt" {
  subnet_id      = oci_core_subnet.private_mgmt.id
  route_table_id = oci_core_route_table.private_mgmt.id
}
