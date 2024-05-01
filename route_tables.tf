# Route Tables
resource "oci_core_route_table" "public_database" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "route-table-public-database"

  route_rules {

    network_entity_id = oci_core_internet_gateway.database.id

    description      = "Route to the Internet Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

# resource "oci_core_route_table" "private_database" {
#   compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
#   vcn_id         = oci_core_vcn.database.id

#   display_name = "route-table-private-database-01"

#   freeform_tags = local.tags.defaults
# }


# Route Table Attachments
resource "oci_core_route_table_attachment" "public_database" {
  subnet_id      = oci_core_subnet.public_database.id
  route_table_id = oci_core_route_table.public_database.id
}

# resource "oci_core_route_table_attachment" "private_database" {
#   subnet_id      = oci_core_subnet.private_database.id
#   route_table_id = oci_core_route_table.private_database.id
# }
