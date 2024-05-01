# Create a reserved public IP for the database compute
resource "oci_core_public_ip" "database" {
  compartment_id = local.values.compartments.production
  lifetime       = "RESERVED"

  display_name = "res-database"

  freeform_tags = local.tags.defaults
}
