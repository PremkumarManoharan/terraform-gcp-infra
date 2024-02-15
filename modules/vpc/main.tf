resource "google_compute_network" "vpc_network" {
  name                              = var.vpc_name
  auto_create_subnetworks           = var.vpc_auto_create_subnetworks
  routing_mode                      = var.vpc_routing_mode
  delete_default_routes_on_create   = var.vpc_delete_default_routes_on_create 
}

# Subnets
resource "google_compute_subnetwork" "subnets" {
  for_each = { for s in toset(var.subnets) : s.name => s }

  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  network       = google_compute_network.vpc_network.name
}

# Routes
resource "google_compute_route" "routes" {
  for_each = { for s in toset(var.routes) : s.name => s }
  name             = each.value.name
  dest_range       = each.value.dest_range
  next_hop_gateway = each.value.next_hop_gateway
  network          = google_compute_network.vpc_network.name
}
