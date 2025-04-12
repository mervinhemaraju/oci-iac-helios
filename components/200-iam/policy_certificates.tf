resource "oci_identity_policy" "certificates_administrators" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators to manage certificates in this tenancy"
  name           = "certificates-administrators"
  statements = [
    "Allow group ${local.values.group.administrators} to manage certificate-authority-family in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
