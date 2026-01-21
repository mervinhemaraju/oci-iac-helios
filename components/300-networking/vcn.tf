# The virtual cloud network for dev and its attachments
resource "oci_core_vcn" "dev" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.dev
  ]

  display_name   = "dev"
  dns_label      = "dev"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}

# Attach HELIOS VCN to HELIOS's DRG (ONE VCN → ONE DRG)
resource "oci_core_drg_attachment" "dev_vcn" {
  drg_id        = oci_core_drg.dev.id
  display_name  = "dev-vcn-drg-attachment"
  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.dev.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}
