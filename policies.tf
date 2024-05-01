
# Create a policy for DRG management as a requestor
resource "oci_identity_policy" "requestor_drg_management" {

  compartment_id = local.values.compartments.root
  description    = "Allow the requestor to manage DRG in this tenancy"
  name           = "requestor-drg-management"
  statements     = []

  freeform_tags = local.tags.defaults
}
