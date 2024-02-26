resource "google_compute_network" "vpc_network" {
  name                              = var.vpc_name
  auto_create_subnetworks           = var.vpc_auto_create_subnetworks
  routing_mode                      = var.vpc_routing_mode
  delete_default_routes_on_create   = var.vpc_delete_default_routes_on_create 
}

# Subnets
resource "google_compute_subnetwork" "subnets" {
  for_each = { for s in toset(var.subnets) : s.name => s }
  name                     = each.value.name
  ip_cidr_range            = each.value.ip_cidr_range
  network                  = google_compute_network.vpc_network.name
  private_ip_google_access = true
}

# Routes
resource "google_compute_route" "routes" {
  for_each = { for s in toset(var.routes) : s.name => s }
  name             = each.value.name
  dest_range       = each.value.dest_range
  next_hop_gateway = each.value.next_hop_gateway
  network          = google_compute_network.vpc_network.name
}

#Firewalls
resource "google_compute_firewall" "vpc-firewall" {
  for_each = { for s in toset(var.firewall) : s.name => s }
  name    = each.value.name
  network = google_compute_network.vpc_network.name
  direction = each.value.direction
  source_ranges = each.value.source_ranges
  target_tags = each.value.target_tags
  priority = each.value.priority
  dynamic "allow" {
        for_each = each.value.allow
        content {
          protocol  = allow.value["protocol"]
          ports     = allow.value["ports"]
        }
  }
  dynamic "deny" {
        for_each = each.value.deny
        content {
          protocol  = deny.value["protocol"]
        }
  }
}

#PRIVATE_SERVICE_CONNECT
resource "google_compute_global_address" "vpc-psc" {
  name         = var.psconnect.name
  address_type = var.psconnect.address_type
  purpose      = var.psconnect.purpose
  network      = google_compute_network.vpc_network.id
  prefix_length = 16
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = var.private_vpc_connection_service
  reserved_peering_ranges = [google_compute_global_address.vpc-psc.name]
  deletion_policy         = var.deletion_policy
}
