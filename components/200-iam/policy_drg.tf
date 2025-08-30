
# Create a policy for VCN management as a acceptor
resource "oci_identity_policy" "acceptor_vcn_management" {

  compartment_id = local.values.compartments.root
  description    = "Allow the acceptor to manage VCN and DRG attachments in this tenancy"
  name           = "acceptor-vcn-management"
  statements = [
    "define group ${oci_identity_group.vcn_admins.name} as ${oci_identity_group.vcn_admins.id}",
    "define group ${local.values.groups.gaia_groups.drg_admins.name} as ${local.values.groups.gaia_groups.drg_admins.id}",
    "define tenancy requestorDRG as ${local.values.compartments.root_gaia}",

    "endorse group ${local.values.groups.gaia_groups.drg_admins.name} to manage virtual-network-family in tenancy requestorDRG",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage virtual-network-family in tenancy requestorDRG",
    "admit group ${local.values.groups.gaia_groups.drg_admins.name} of tenancy requestorDRG to manage drg-attachment in tenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage drg in tenancy requestorDRG",
  ]

  freeform_tags = local.tags.defaults
}
