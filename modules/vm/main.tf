

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

metadata_startup_script = <<-EOF
  #!/bin/bash
  echo "PG_HOST=${var.dbhostname}" > /opt/app/.env
  echo "PG_USER=${var.dbuser}" >> /opt/app/.env
  echo "PG_PASSWORD=${var.dbpassword}" >> /opt/app/.env
  echo "PG_DB=${var.database}" >> /opt/app/.env
  touch /opt/app/start.txt
EOF


  
}

data "google_compute_image" "my_image" {
  family  = var.family
  project = var.family_project
}
