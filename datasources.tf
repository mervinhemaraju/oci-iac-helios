# * Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# * Gets the availability domain from OCI
data "oci_identity_availability_domain" "availability_domain" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  ad_number      = 1
}

# # * Gets the OCID of the private address
# data "oci_core_private_ips" "private-ips-web-01" {
#   ip_address = var.instance_private_id_web_01
#   subnet_id  = oci_core_subnet.web_public.id

#   depends_on = [
#     oci_core_instance.web-01,
#     oci_core_subnet.web_public
#   ]
# }
