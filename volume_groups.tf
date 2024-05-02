resource "oci_core_volume_group" "database" {
  availability_domain = data.oci_identity_availability_domain.this.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

  display_name = "database-volumes"

  source_details {
    type = "volumeIds"
    volume_ids = [
      oci_core_instance.mongo.boot_volume_id
    ]
  }
  freeform_tags = local.tags.defaults
}
