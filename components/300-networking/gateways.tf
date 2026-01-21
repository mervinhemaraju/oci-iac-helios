# Create a main Internet gateway for dev
resource "oci_core_internet_gateway" "dev" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.dev.id

  enabled      = true
  display_name = "dev-ig"

  freeform_tags = local.tags.defaults
}

# Create a main NAT gateway for dev
resource "oci_core_nat_gateway" "dev" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.dev.id

  display_name  = "dev-ng"
  freeform_tags = local.tags.defaults
}

# Create a Dynamic Routing Gateway for VCN peering
resource "oci_core_drg" "dev" {
  compartment_id = local.values.compartments.production

  display_name = "dev-drg"

  freeform_tags = local.tags.defaults
}

# Create a Local Peering Gateway for HELIOS -> GAIA (same region)
# resource "oci_core_local_peering_gateway" "to_gaia" {
#   compartment_id = local.values.compartments.production
#   vcn_id         = oci_core_vcn.dev.id

#   display_name = "lpg-to-gaia"

#   # The peer_id references Gaia's LPG - only set on ONE side (requestor)
#   peer_id = local.networking.gateways.gaia_lpg

#   freeform_tags = local.tags.defaults
# }
