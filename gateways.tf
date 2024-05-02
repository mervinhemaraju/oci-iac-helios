# Create a main Internet gateway for database
resource "oci_core_internet_gateway" "database" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  enabled      = true
  display_name = "database-ig"

  freeform_tags = local.tags.defaults
}

# Create a Dynamic Routing Gateway for VCN peering
resource "oci_core_drg" "database" {
  compartment_id = local.values.compartments.production

  display_name = "database-drg"

  freeform_tags = local.tags.defaults
}
