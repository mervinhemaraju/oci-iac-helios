# Create a main Internet gateway for the compartment
resource "oci_core_internet_gateway" "prod" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.database.id

  enabled      = true
  display_name = "prod-ig"

  freeform_tags = local.tags.defaults
}
