resource "oci_identity_policy" "ca_dg" {

  compartment_id = local.values.compartments.root
  description    = "Allow the certificate autohorities dynamic group to manage certificates in this tenancy"
  name           = "ca-dg"
  statements = [
    "Allow dynamic-group ${local.values.groups.ca_dg} to use keys in tenancy",
    "Allow dynamic-group ${local.values.groups.ca_dg} to manage objects in tenancy",
  ]

  freeform_tags = local.tags.defaults
}
