
# > OCI Compute Instance Resources

# * Create a compute instance for web 01
resource "oci_core_instance" "web_01" {

  availability_domain = data.oci_identity_availability_domain.availability_domain.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

  display_name = "web-01"

  shape = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = oci_core_subnet.web_public.id
    assign_public_ip = false
    private_ip       = local.constants.compute.ip_address.web_01.private
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

# * Create a compute instance for web 02
resource "oci_core_instance" "web_02" {

  availability_domain = data.oci_identity_availability_domain.availability_domain.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

  display_name = "web-02"

  shape = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = oci_core_subnet.web_public.id
    assign_public_ip = false
    private_ip       = local.constants.compute.ip_address.web_02.private
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
