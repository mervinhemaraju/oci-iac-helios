# Creates a new user gorup for drg admins
resource "oci_identity_group" "drg_admins" {

  compartment_id = local.values.compartments.production

  description = "Dynamic Routing Gateway Admininistrators"
  name        = "drg-admins"

  freeform_tags = local.tags.defaults
}
