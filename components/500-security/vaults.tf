resource "oci_kms_vault" "mervinhemaraju_root_ca" {
  #Required
  compartment_id = local.values.compartments.production
  display_name   = "mervinhemaraju-root-ca-vault"
  vault_type     = "DEFAULT"

  # external_key_manager_metadata {
  #     #Required
  #     external_vault_endpoint_url = var.vault_external_key_manager_metadata_external_vault_endpoint_url
  #     oauth_metadata {
  #         #Required
  #         client_app_id = oci_kms_client_app.test_client_app.id
  #         client_app_secret = var.vault_external_key_manager_metadata_oauth_metadata_client_app_secret
  #         idcs_account_name_url = var.vault_external_key_manager_metadata_oauth_metadata_idcs_account_name_url
  #     }
  #     private_endpoint_id = oci_dataflow_private_endpoint.test_private_endpoint.id
  # }

  freeform_tags = local.tags.defaults
}
