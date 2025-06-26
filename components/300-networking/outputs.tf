
# Create output for LB Public IP
output "web_lb_public_ip" {
  value       = oci_core_public_ip.web.ip_address
  description = "Public IP address of the web Load Balancer"
}
