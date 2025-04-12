resource "oci_kms_key" "mervinhemaraju_root_ca" {
  compartment_id      = local.values.compartments.production
  display_name        = "mervinhemaraju-root-ca-key"
  management_endpoint = oci_kms_vault.mervinhemaraju_root_ca.management_endpoint
  key_shape {
    algorithm = "RSA"
    length    = "256"
  }
  protection_mode = "HSM"

  freeform_tags = local.tags.defaults
}
