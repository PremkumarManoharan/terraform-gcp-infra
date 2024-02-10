resource "google_compute_network" "vpc_network" {
  name                              = "vpc-network"
  auto_create_subnetworks           = false
  routing_mode                      = "REGIONAL"
  delete_default_routes_on_create   = true 
}

resource "google_compute_subnetwork" "webapp" {
  name          = "webapp"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "db" {
  name          = "db"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_route" "webapp-route" {
  name        = "webapp-route"
  dest_range  = "0.0.0.0/0"
  network     = google_compute_network.vpc_network.name
  next_hop_gateway = "default-internet-gateway"
}
