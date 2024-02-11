# * Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# * Gets the availability domain from OCI
data "oci_identity_availability_domain" "availability_domain" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  ad_number      = 1
}

# * Gets the OCID of the private address
data "oci_core_private_ips" "web_01" {
  ip_address = local.constants.compute.ip_address.web_01
  subnet_id  = oci_core_subnet.web_public.id

  depends_on = [
    oci_core_instance.web_01,
    oci_core_subnet.web_public
  ]
}

# * Gets the OCID of the private address
data "oci_core_private_ips" "web_02" {
  ip_address = local.constants.compute.ip_address.web_02
  subnet_id  = oci_core_subnet.web_public.id

  depends_on = [
    oci_core_instance.web_02,
    oci_core_subnet.web_public
  ]
}
