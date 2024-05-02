resource "oci_core_drg_attachment" "database" {

  drg_id = oci_core_drg.database.id

  display_name = "database-vcn"

  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.database.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}
