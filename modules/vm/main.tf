

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
  ENV_FILE="/opt/app/.env"
  
  # Check if .env file already exists
  if [ ! -f "$ENV_FILE" ]; then
    # Create .env file
    cat <<EOL > "$ENV_FILE"
    PG_HOST=${var.dbhostname}
    PG_USER=${var.dbuser}
    PG_PASSWORD=${var.dbpassword}
    PG_DB=${var.database}
  EOL
    touch /opt/app/start.txt
  fi
EOF


  
}

data "google_compute_image" "my_image" {
  family  = var.family
  project = var.family_project
}
