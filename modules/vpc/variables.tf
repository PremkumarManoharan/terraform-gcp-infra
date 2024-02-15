
variable "vpc_name" {
  type        = string
  description = "Name of VPC"
}

variable "vpc_auto_create_subnetworks" {
  type        = bool
  description = "Auto Create subnets?"
}

variable "vpc_routing_mode" {
  type        = string
  description = "Routing Mode"
}

variable "vpc_delete_default_routes_on_create" {
  type        = bool
  description = "Delete default routes in VPC?"
}

variable "subnets" {
  description = "A list of objects containing subnet details."
  type = list(object({
    name          = string
    ip_cidr_range = string
  }))
  default = []
}

variable "routes" {
  description = "A list of objects containing route details."
  type = list(object({
    name            = string
    dest_range      = string
    next_hop_gateway = string
  }))
}
