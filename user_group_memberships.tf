# Creates a user group membership for the DRG admins group
resource "oci_identity_user_group_membership" "drg_admins" {
  group_id = oci_identity_group.drg_admins.id
  user_id  = data.oci_identity_users.main_admin.users[0].id
}
