

# Create a public subnet for the web resources
resource "oci_core_subnet" "public_web" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.public_web
  vcn_id     = oci_core_vcn.web.id

  display_name               = "public-web"
  dns_label                  = "publicweb"
  prohibit_public_ip_on_vnic = false
  security_list_ids          = [oci_core_security_list.public_web.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web
  ]
}


# Create a private subnet for the web resources
resource "oci_core_subnet" "private_web" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_web
  vcn_id     = oci_core_vcn.web.id

  display_name               = "private-web"
  dns_label                  = "privateweb"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_web.id]

  route_table_id = oci_core_route_table.private_web.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web
  ]
}

# Create a private subnet for the bastions
resource "oci_core_subnet" "private_mgmt" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_mgmt
  vcn_id     = oci_core_vcn.web.id

  display_name               = "private-mgmt"
  dns_label                  = "privatemgmt"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_mgmt.id]

  route_table_id = oci_core_route_table.private_mgmt.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web
  ]
}
