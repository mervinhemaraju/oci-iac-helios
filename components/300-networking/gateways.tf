# Create a main Internet gateway for web
resource "oci_core_internet_gateway" "web" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  enabled      = true
  display_name = "web-ig"

  freeform_tags = local.tags.defaults
}
