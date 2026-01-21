resource "oci_core_volume_group" "database" {
  compartment_id      = local.values.compartments.production
  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = "database-volumes"

  source_details {
    type = "volumeIds"
    volume_ids = [
      oci_core_instance.mongo.boot_volume_id
    ]
  }
  freeform_tags = local.tags.defaults
}
