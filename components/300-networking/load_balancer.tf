
# Load balancer definition
resource "oci_load_balancer_load_balancer" "web" {
  compartment_id = local.values.compartments.production
  display_name   = "web"
  shape          = "flexible"
  subnet_ids     = [oci_core_subnet.public_web.id]

  ip_mode = "IPV4"
  # is_delete_protection_enabled = "false"
  is_private = false
  # is_request_id_enabled = false
  # network_security_group_ids = var.load_balancer_network_security_group_ids
  # request_id_header = var.load_balancer_request_id_header
  reserved_ips {
    id = oci_core_public_ip.web.id
  }

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  freeform_tags = local.tags.defaults
}

# Backend Set
resource "oci_load_balancer_backend_set" "web_http" {

  load_balancer_id = oci_load_balancer_load_balancer.web.id
  name             = "web_http_backends"
  policy           = "WEIGHTED_ROUND_ROBIN"

  backend {
    name       = "web_01"
    ip_address = local.networking.ip_address.web_01
    backup     = false
    offline    = false
    drain      = false
    weight     = 1
    port       = 80
  }

  backend {
    name       = "web_02"
    ip_address = local.networking.ip_address.web_02
    backup     = false
    offline    = false
    drain      = false
    weight     = 1
    port       = 80
  }

  health_checker {
    protocol = "HTTP"

    # interval_ms         = var.backend_set_health_checker_interval_ms
    # is_force_plain_text = var.backend_set_health_checker_is_force_plain_text
    port = 80
    # response_body_regex = var.backend_set_health_checker_response_body_regex
    retries     = 3
    return_code = 200
    # timeout_in_millis   = var.backend_set_health_checker_timeout_in_millis
    url_path = "/"
  }


  # lb_cookie_session_persistence_configuration {

  #     #Optional
  #     cookie_name = var.backend_set_lb_cookie_session_persistence_configuration_cookie_name
  #     disable_fallback = var.backend_set_lb_cookie_session_persistence_configuration_disable_fallback
  #     domain = var.backend_set_lb_cookie_session_persistence_configuration_domain
  #     is_http_only = var.backend_set_lb_cookie_session_persistence_configuration_is_http_only
  #     is_secure = var.backend_set_lb_cookie_session_persistence_configuration_is_secure
  #     max_age_in_seconds = var.backend_set_lb_cookie_session_persistence_configuration_max_age_in_seconds
  #     path = var.backend_set_lb_cookie_session_persistence_configuration_path
  # }

  # session_persistence_configuration {
  #     #Required
  #     cookie_name = var.backend_set_session_persistence_configuration_cookie_name

  #     #Optional
  #     disable_fallback = var.backend_set_session_persistence_configuration_disable_fallback
  # }

  # ssl_configuration {

  #     #Optional
  #     certificate_ids = var.backend_set_ssl_configuration_certificate_ids
  #     certificate_name = oci_load_balancer_certificate.test_certificate.name
  #     cipher_suite_name = var.backend_set_ssl_configuration_cipher_suite_name
  #     protocols = var.backend_set_ssl_configuration_protocols
  #     server_order_preference = var.backend_set_ssl_configuration_server_order_preference
  #     trusted_certificate_authority_ids = var.backend_set_ssl_configuration_trusted_certificate_authority_ids
  #     verify_depth = var.backend_set_ssl_configuration_verify_depth
  #     verify_peer_certificate = var.backend_set_ssl_configuration_verify_peer_certificate
  # }

  depends_on = [
    oci_load_balancer_load_balancer.web
  ]
}

# Listeners
resource "oci_load_balancer_listener" "web_http" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.web_http.name
  load_balancer_id         = oci_load_balancer_load_balancer.web.id
  name                     = "web_http_listeners"
  port                     = 80
  protocol                 = "HTTP"

  # hostname_names = [oci_load_balancer_hostname.test_hostname.name]
  # path_route_set_name = oci_load_balancer_path_route_set.test_path_route_set.name
  # routing_policy_name = oci_load_balancer_load_balancer_routing_policy.test_load_balancer_routing_policy.name
  # rule_set_names = [oci_load_balancer_rule_set.test_rule_set.name]

  depends_on = [
    oci_load_balancer_load_balancer.web,
    oci_load_balancer_backend_set.web_http,
  ]
}

# Backends
resource "oci_load_balancer_backend" "web_01" {
  backendset_name  = oci_load_balancer_backend_set.web_http.name
  ip_address       = local.networking.ip_address.web_01
  load_balancer_id = oci_load_balancer_load_balancer.web.id
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1

  depends_on = [
    oci_load_balancer_load_balancer.web,
    oci_load_balancer_backend_set.web_http,
  ]
}

resource "oci_load_balancer_backend" "web_02" {
  backendset_name  = oci_load_balancer_backend_set.web_http.name
  ip_address       = local.networking.ip_address.web_02
  load_balancer_id = oci_load_balancer_load_balancer.web.id
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1

  depends_on = [
    oci_load_balancer_load_balancer.web,
    oci_load_balancer_backend_set.web_http,
  ]
}
