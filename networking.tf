# Create a virtual cloud network for OCI
resource "oci_core_vcn" "database" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

  cidr_blocks = [
    local.networking.cidr.vcn.database
  ]

  display_name   = "database"
  dns_label      = "database"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}

# Create a public web subnet
resource "oci_core_subnet" "public_database" {

  cidr_block     = local.networking.cidr.subnets.public_database
  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.database.id

  display_name               = "public-database"
  dns_label                  = "publicdatabase"
  prohibit_public_ip_on_vnic = false
  security_list_ids          = [oci_core_security_list.public_database.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.database,
    oci_core_security_list.public_database
  ]
}

# Create a private subnet
resource "oci_core_subnet" "private_database" {

  cidr_block     = local.networking.cidr.subnets.private_database
  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.database.id

  display_name               = "private-database"
  dns_label                  = "privatedatabase"
  prohibit_public_ip_on_vnic = false
  security_list_ids          = [oci_core_security_list.private_database.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.database,
    oci_core_security_list.private_database
  ]
}
