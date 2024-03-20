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
      target_tags = set(string)
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
    name         = string
    address_type = string
    purpose      = string
    prefix_length      = number
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
    sa_scopes         = list(string)
  }))
}


variable "sql_instance" {
  type        = list(object({
    sql_instance_name      = string
    database_version       = string
    tier                   = string
    availability_type      = string
    disk_size              = number
    disk_type              = string
    ipv4_enabled           = bool
    vpc_name               = string
    edition                = string
    deletion_protection_enabled = bool
    database               = object({
            name = string
            username = string
            password_length = number
            password_special = bool
        })
  }))
  description = "Deatils of SQL Instance"
}


variable "dns_zone_records" {
   type            = list(object({
    dns_zone_name  = string
    domain_name    = string
    record_type    = string
    record_ttl     = number
    instance_name  = string
   }))
}

variable "service_accounts" {
  type = list(object({
    account_id = string
    display_name = string
  }))
}

variable "project_role_bindings" {
  type = list(object({
     project  = string 
     role     = string
     userType = string
     account_id = string
  }))
}
