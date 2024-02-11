
# * Create a reserved public ip for web 01
resource "oci_core_public_ip" "web_01" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  lifetime       = "RESERVED"

  display_name  = "res-ip-web-01"
  private_ip_id = data.oci_core_private_ips.web_01.private_ips[0]["id"]

  depends_on = [
    oci_core_subnet.web_public
  ]
}


# * Create a reserved public ip for web 02
resource "oci_core_public_ip" "web_02" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  lifetime       = "RESERVED"

  display_name  = "res-ip-web-02"
  private_ip_id = data.oci_core_private_ips.web_02.private_ips[0]["id"]

  depends_on = [
    oci_core_subnet.web_public
  ]
}
