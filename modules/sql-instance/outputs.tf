
output "username" {
  value = google_sql_user.users-1.name
}

output "password" {
  value = google_sql_user.users-1.password
}

output "PrivateIp" {
    value = google_sql_database_instance.instance.private_ip_address
}
