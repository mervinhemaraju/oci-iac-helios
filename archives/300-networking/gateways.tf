# Create a main Internet gateway for Web
resource "oci_core_internet_gateway" "web" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  enabled      = true
  display_name = "web-ig"

  freeform_tags = local.tags.defaults
}

# Create a main NAT gateway for Web
resource "oci_core_nat_gateway" "web" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name  = "web-ng"
  freeform_tags = local.tags.defaults
}
