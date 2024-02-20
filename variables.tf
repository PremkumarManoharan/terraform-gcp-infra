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
      direction     = string
      source_ranges = set(string)
      allow = list(object({
        protocol = string
        ports    = list(string)
      }))
    }))
  }))
}

variable "webapp-vm" {
  type = object({
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
  })
}
