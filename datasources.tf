# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Get the latest Oracle 9 Image
data "oci_core_images" "oracle_linux" {
  compartment_id           = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                    = local.values.compute.shape
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  ad_number      = 1
}

# Gets the fault domains from this AZ
data "oci_identity_fault_domains" "this" {
  availability_domain = data.oci_identity_availability_domain.this.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
}

# Get ths private ips for mongo compute
data "oci_core_private_ips" "mongo" {
  ip_address = local.networking.ip_address.mongo
  subnet_id  = oci_core_subnet.public_database.id

  depends_on = [
    oci_core_instance.mongo,
    oci_core_subnet.public_database
  ]
}
