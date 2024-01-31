
# > OCI Compute Instance Resources
# * Create a compute instance for web
resource "oci_core_instance" "web_01" {

  availability_domain = data.oci_identity_availability_domain.availability_domain.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

  display_name = "web-01"

  shape = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = oci_core_subnet.web_public.id
    assign_public_ip = false
    private_ip       = "10.16.1.223"
  }

  source_details {
    source_type             = "image"
    source_id               = local.constants.compute.image.ubuntu_oci
    boot_volume_size_in_gbs = "80"
  }

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPUTE_KEY_PUBLIC
  }

}

# * Create a reserved public ip
resource "oci_core_public_ip" "web_01" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  lifetime       = "RESERVED"

  display_name  = "res-ip-web-01"
  private_ip_id = data.oci_core_private_ips.web_01.private_ips[0]["id"]

  depends_on = [
    oci_core_subnet.web_public
  ]
}
