# Create a NAT gateway for the database computes
resource "oci_core_nat_gateway" "database" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "database-nat"

  public_ip_id = oci_core_public_ip.database.id

  freeform_tags = local.tags.defaults
}

# Create a Dynamic Routing Gateway for VCN peering

resource "oci_core_drg" "database" {
  compartment_id = local.values.compartments.production

  display_name = "database-drg"

  freeform_tags = local.tags.defaults
}
