variable "region" {
  type        = string
  description = "GCP region for all resources."
  default     = "us-east1"
}

variable "project_name" {
  type        = string
  description = "Name of the example project."
  default     = "csye-6225-dev-413816"
}

variable "vpcs" {
  description = "Configuration for VPC1"
  type = list(object({
    vpc_name                            = string
    vpc_auto_create_subnetworks         = bool
    vpc_routing_mode                    = string
    vpc_delete_default_routes_on_create = bool
    subnets = list(object({
      name          = string
      ip_cidr_range = string
    }))
    routes = list(object({
      name             = string
      dest_range       = string
      next_hop_gateway = string
    }))
    firewall = list(object({
      name          = string
      priority      = number
      direction     = string
      source_ranges = set(string)
      target_tags   = set(string)
      allow = list(object({
        protocol = string
        ports    = list(string)
      }))
      deny = list(object({
        protocol = string
        ports    = list(string)
      }))
    }))
    psconnect = object({
      name          = string
      address_type  = string
      purpose       = string
      prefix_length = number
    })
    private_vpc_connection_service = string
  }))

}


variable "vms" {
  type = list(object({
    family            = string
    family_project    = string
    name              = string
    machine_type      = string
    size              = number
    subnet            = string
    tags              = list(string)
    type              = string
    zone              = string
    network_tier      = string
    database_instance = string
    database_name     = string
    account_id        = string
    pubsubtopic       = string
    sa_scopes         = list(string)
  }))
}


variable "sql_instance" {
  type = list(object({
    sql_instance_name           = string
    database_version            = string
    tier                        = string
    availability_type           = string
    disk_size                   = number
    disk_type                   = string
    ipv4_enabled                = bool
    vpc_name                    = string
    edition                     = string
    deletion_protection_enabled = bool
    database = object({
      name             = string
      username         = string
      password_length  = number
      password_special = bool
    })
  }))
  description = "Deatils of SQL Instance"
}


variable "dns_zone_records" {
  type = list(object({
    dns_zone_name = string
    domain_name   = string
    record_type   = string
    record_ttl    = number
    instance_name = string
    load_balancer = string
  }))
}

variable "service_accounts" {
  type = list(object({
    account_id   = string
    display_name = string
  }))
}

variable "project_role_bindings" {
  type = list(object({
    project    = string
    role       = string
    userType   = string
    account_id = string
  }))
}

variable "vpc_connectors" {
  type = list(object({
    name   = string
    subnet = string
  }))
}

variable "cloud_functions" {
  type = list(object({
    name                           = string
    account_id_pubsub              = string
    account_id_function            = string
    topic                          = string
    database_instance              = string
    vpc_connector_name             = string
    location                       = string
    runtime                        = string
    entry_point                    = string
    bucket                         = string
    object                         = string
    SENDGRID_API_KEY               = string
    PG_DB                          = string
    max_instance_count             = number
    min_instance_count             = number
    available_memory               = string
    available_cpu                  = string
    timeout_seconds                = number
    ingress_settings               = string
    all_traffic_on_latest_revision = bool
    event_type                     = string
    retry_policy                   = string
    vpc_connector_egress_settings  = string
    generation                     = string
  }))
}

variable "pub_sub_topics" {
  type = list(object({
    name                       = string
    message_retention_duration = string
  }))
}

variable "instance_templates" {
  type = list(object({
    name               = string
    description        = string
    disk_size_gb       = number
    tags               = list(string)
    disk_type          = string
    machine_type       = string
    network_tier       = string
    scopes             = list(string)
    subnetwork         = string
    database           = string
    family             = string
    family_project     = string
    pubsubtopic        = string
    vm_service_account = string
    database_instance  = string
  }))
}

variable "instance-groups" {
  type = list(object({
    instance_template = string
    autoscaling = object({
      name                             = string
      max_replicas                     = number
      min_replicas                     = number
      cooldown_period                  = number
      cpu_util_target                  = number
      max_scaled_in_replicas_fixed     = number
      scale_in_control_time_window_sec = number
    })
    http-health-check = object({
      name                = string
      description         = string
      timeout_sec         = number
      check_interval_sec  = number
      healthy_threshold   = number
      unhealthy_threshold = number
      port_name           = string
      port                = number
      request_path        = string

    })
    igm = object({
      name                      = string
      base_instance_name        = string
      version_name              = string
      port_name                 = string
      port                      = number
      initial_delay_sec         = number
      force_update_on_repair    = string
      default_action_on_failure = string
    })
  }))
}

variable "load-balancers" {
  type = list(object({
    name                            = string
    project                         = string
    backend_port                    = number
    backend_port_name               = string
    backend_protocol                = string
    backend_timeoout_sec            = number
    enable_cdn                      = bool
    health_check_port               = number
    health_check_request_path       = string
    iap_config_enable               = bool
    log_config_enable               = bool
    managed_ssl_certificate_domains = list(string)
    ssl                             = bool
    vpc_network                     = string
    target_tags                     = list(string)
    http_forward                    = bool
    igm                             = string
  }))
}
