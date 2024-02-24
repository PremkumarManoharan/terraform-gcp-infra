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
    family         = string
    family_project = string
    name           = string
    machine_type   = string
    size           = number
    subnet         = string
    tags           = list(string)
    type           = string
    zone           = string
    network_tier   = string
  }))
}

variable "database" {
  type = string
  default = "my-database"
}

variable "sql_instance" {
  type        = object({
    sql_instance_name      = string
    database_version       = string
    tier                   = string
    availability_type      = string
    disk_size              = number
    ipv4_enabled           = bool
    deletion_protection_enabled = bool
    database               = object({
            name = string
            username_length = number
            username_special = bool
            password_length = number
            password_special = bool
        })
  })
  description = "Deatils of SQL Instance"
}
