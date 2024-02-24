
output "username" {
  value = random_string.random_username.result
}

output "password" {
  value = random_string.random_password.result
}

output "PrivateIp" {
    value = google_sql_database_instance.instance.private_ip_address
}
