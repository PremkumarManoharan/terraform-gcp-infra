module "gce-lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  version           = "~> 9.0"

  project           = var.project
  name              = var.name
  firewall_networks = var.firewall_networks
  target_tags       = var.target_tags
  ssl               = var.ssl
  http_forward      = var.http_forward
  managed_ssl_certificate_domains = var.managed_ssl_certificate_domains
  backends = {
    default = {
      port                            = var.backend_port
      protocol                        = var.backend_protocol
      port_name                       = var.backend_port_name
      timeout_sec                     = var.backend_timeoout_sec
      enable_cdn                      = var.enable_cdn

      log_config = {
        enable      = var.log_config_enable
      }
      

      health_check = {
        request_path        = var.health_check_request_path
        port                = var.health_check_port
      }
      groups = [
        {
          group             = var.backend-group
        },
      ]

      iap_config = {
        enable               = var.iap_config_enable
      }
    }
  }
}
