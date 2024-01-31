# * Create a virtual cloud network for OCI
resource "oci_core_vcn" "web" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

  cidr_blocks    = ["10.16.0.0/16"]
  display_name   = "web-vcn"
  dns_label      = "web"
  is_ipv6enabled = false
}

# * Create a public subnet for web
resource "oci_core_subnet" "web_public" {

  cidr_block     = "10.16.1.0/24"
  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name               = "subnet-public-web"
  dns_label                  = "publicweb"
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_vcn.web.default_route_table_id
  security_list_ids          = [oci_core_vcn.web.default_security_list_id, oci_core_security_list.web_main.id]

  depends_on = [
    oci_core_vcn.web,
    oci_core_security_list.web_main
  ]
}

# * Create a main Internet gateway for the compartment
resource "oci_core_internet_gateway" "prod" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  enabled      = true
  display_name = "prod-ig"

  depends_on = [
    oci_core_vcn.web
  ]
}
