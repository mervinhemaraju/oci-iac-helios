# Create a reserved public IP for the database compute
resource "oci_core_public_ip" "database" {
  compartment_id = local.values.compartments.production
  lifetime       = "RESERVED"

  display_name = "res-database"

  private_ip_id = data.oci_core_private_ips.mongo.private_ips[0]["id"]

  freeform_tags = local.tags.defaults
}
