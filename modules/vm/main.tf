

resource "google_compute_instance" "webapp" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.my_image.self_link
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

data "google_compute_image" "my_image" {
  family  = "csye6225-webapp"
  project = "csye-6225-dev-413816"
}
