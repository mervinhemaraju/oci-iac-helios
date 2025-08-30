# The virtual cloud network and its attachments for Web
resource "oci_core_vcn" "web" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.web
  ]

  display_name   = "web"
  dns_label      = "web"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}

# > Attachment to the Dataabse DRG in oci gaia account
resource "oci_core_drg_attachment" "database_gaia" {

  drg_id = local.gaia_account.database_drg["id"]

  display_name = "database-gaia-drg-attachment"

  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.web.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}
