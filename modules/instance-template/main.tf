resource "google_compute_region_instance_template" "instance-template" {
  name        = var.name
  description = var.description

  tags = var.tags
  machine_type         = var.machine_type

  disk {
    source_image      = data.google_compute_image.my_image.self_link
    disk_type         = var.disk_type
    disk_size_gb      = var.disk_size_gb

  }

  network_interface {
    subnetwork = var.subnetwork
    access_config{
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
    TOPIC_EMAIL=${var.pubsubtopic}
  EOL
    touch /opt/app/start.txt
  fi
EOF

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.email
    scopes = var.scopes
  }
}

data "google_compute_image" "my_image" {
  family  = var.family
  project = var.family_project
}
