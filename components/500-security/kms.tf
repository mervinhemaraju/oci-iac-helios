# resource "oci_kms_key" "mervinhemaraju_root_ca" {
#   compartment_id = local.values.compartments.production
#   display_name   = "mervinhemaraju-root-ca-key"
#   key_shape {
#     algorithm = "RSA"
#     length    = "2048"
#   }
#   management_endpoint = "CREATE"
#   protection_mode     = "HSM"

#   freeform_tags = local.tags.defaults
# }
