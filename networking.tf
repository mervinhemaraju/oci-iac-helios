# * Create a virtual cloud network for OCI
resource "oci_core_vcn" "prod-web-vcn" {

  compartment_id = data.doppler_secrets.this.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

  cidr_blocks    = ["10.16.0.0/16"]
  display_name   = "web-vcn"
  dns_label      = "web"
  is_ipv6enabled = false
}
