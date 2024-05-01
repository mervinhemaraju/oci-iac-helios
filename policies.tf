
# Create a policy for DRG management as a requestor
resource "oci_identity_policy" "requestor_drg_management" {

  compartment_id = local.values.compartments.root
  description    = "Allow the requestor to manage DRG in this tenancy"
  name           = "requestor-drg-management"
  statements = [
    "define group ${oci_identity_group.drg_admins.name} as ${oci_identity_group.drg_admins.id}",
    "Allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
