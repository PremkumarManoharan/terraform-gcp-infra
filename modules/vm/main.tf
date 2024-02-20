

resource "google_compute_instance" "webapp" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }
  network_interface {
    subnetwork = var.subnet
    access_config {
      network_tier = var.network_tier
    }
  }
  
}
