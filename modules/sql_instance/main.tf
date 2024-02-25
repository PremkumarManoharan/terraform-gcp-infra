resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  name             = "${var.sql_instance.sql_instance_name}-${random_id.db_name_suffix.hex}"
  database_version = var.sql_instance.database_version

  settings {
    tier = var.sql_instance.tier
    edition = var.sql_instance.edition
    availability_type = var.sql_instance.availability_type
    disk_size = var.sql_instance.disk_size
    deletion_protection_enabled = var.sql_instance.deletion_protection_enabled
    ip_configuration {
      ipv4_enabled                                  = var.sql_instance.ipv4_enabled
      private_network                               = var.private_network
    }
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = var.sql_instance.database.name
  instance = google_sql_database_instance.instance.name
}

resource "random_string" "random_password" {
   length  = var.sql_instance.database.password_length
  special = var.sql_instance.database.password_special
}

resource "google_sql_user" "users-1" {
  name     = var.sql_instance.database.username
  instance = google_sql_database_instance.instance.name
  password = random_string.random_password.result
}
