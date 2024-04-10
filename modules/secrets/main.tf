resource "google_secret_manager_secret" "db_host" {
  secret_id = var.secret_id
  replication {
    auto {}
  }
}
resource "google_secret_manager_secret_version" "db_host" {
  secret = google_secret_manager_secret.db_host.id
  secret_data = var.secret_data
}
