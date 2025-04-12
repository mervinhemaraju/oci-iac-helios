resource "oci_identity_policy" "vaults_administrators" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators to manage vaults in this tenancy"
  name           = "vaults-administrators"
  statements = [
    "Allow group Administrators to manage vaults in tenancy",
    "Allow group Administrators to manage keys in tenancy",
    "Allow group Administrators to manage secret-family in tenancy",
    "Allow group Administrators to use key-delegate in tenancy"
  ]

  freeform_tags = local.tags.defaults
}

resource "oci_identity_policy" "certificates_administrators" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators to manage certificates in this tenancy"
  name           = "certificates-administrators"
  statements = [
    "Allow group Administrators to manage certificate-authority-family in tenancy"
  ]

  freeform_tags = local.tags.defaults
}

resource "oci_identity_policy" "buckets_administrators" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators to manage buckets in this tenancy"
  name           = "buckets-administrators"
  statements = [
    "Allow group Administrators to manage buckets in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
