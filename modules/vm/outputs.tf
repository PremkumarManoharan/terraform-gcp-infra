output "PublicIp" {
    value = google_compute_instance.webapp.network_interface[0].access_config[0].nat_ip
}
