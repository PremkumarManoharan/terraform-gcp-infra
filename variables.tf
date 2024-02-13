
variable "region" {
  type        = string
  description = "GCP region for all resources."
}

variable "project_name" {
  type        = string
  description = "Name of the example project."
}

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

variable "webapp_subnet_name" {
  type = string
  description = "Name of the webapp Subnet"
}

variable "webapp_ip_cidr_range" {
  type = string
  description = "Cidr range of the webapp Subnet"
}

variable "db_subnet_name" {
  type = string
  description = "Name of the webapp Subnet"
}

variable "db_ip_cidr_range" {
  type = string
  description = "Cidr range of the webapp Subnet"
}

variable "webapp_route_name" {
  description = "Name of routes to create"
  type = string
}

variable "webapp_route_dest_range" {
  description = "Destination range for route"
  type = string
}

variable "webapp_route_next_hop_gateway" {
  description = "next_hop_gateway for route"
  type = string
}
