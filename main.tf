resource "google_compute_network" "vpc_network" {
  name                              = var.vpc_name
  auto_create_subnetworks           = var.vpc_auto_create_subnetworks
  routing_mode                      = var.vpc_routing_mode
  delete_default_routes_on_create   = var.vpc_delete_default_routes_on_create 
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name          = var.webapp_subnet_name
  ip_cidr_range = var.webapp_ip_cidr_range
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = var.db_subnet_name
  ip_cidr_range = var.db_ip_cidr_range
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_route" "webapp-route" {
  name        =  var.webapp_route_name
  dest_range  =  var.webapp_route_dest_range
  next_hop_gateway = var.webapp_route_next_hop_gateway
  network     = google_compute_network.vpc_network.name
}
