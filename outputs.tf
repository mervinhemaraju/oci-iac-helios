output "public_ip_web_01" {
  value = oci_core_public_ip.web_01.ip_address
}

# output "public_ip_web_02" {
#   value = oci_core_public_ip.web_02.ip_address
# }

output "private_ip_web_01" {
  value = oci_core_instance.web_01.private_ip
}

# output "private_ip_web_02" {
#   value = oci_core_instance.web_02.private_ip
# }
