
resource "oci_identity_dynamic_group" "ca" {
  compartment_id = local.values.compartments.root
  name           = local.values.group.ca_dg

  description   = "Dynamic group for Certificate Authorities"
  matching_rule = "resource.type='certificateauthority'"

  freeform_tags = local.tags.defaults
}
