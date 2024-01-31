locals {

  constants = {
    # compartment_id_production = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID


    compute = {

      image = {
        ubuntu_oci = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa7njfmfxcybo66dwsn4u6asz5ecsszyto56ufbltkp7kugixnctxa"
      }

    }
  }
}
