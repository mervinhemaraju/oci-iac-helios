resource "oci_identity_policy" "vaults_administrators" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators to manage vaults in this tenancy"
  name           = "vaults-administrators"
  statements = [
    "Allow group ${local.values.group.administrators} to manage vaults in tenancy",
    "Allow group ${local.values.group.administrators} to manage keys in tenancy",
    "Allow group ${local.values.group.administrators} to manage secret-family in tenancy",
    "Allow group ${local.values.group.administrators} to use key-delegate in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
