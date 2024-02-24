
variable "sql_instance" {
  type        = object({
    sql_instance_name      = string
    database_version       = string
    tier                   = string
    availability_type      = string
    disk_size              = number
    ipv4_enabled           = bool
    deletion_protection_enabled = bool
    database               = object({
            name = string
            username_length = number
            username_special = bool
            password_length = number
            password_special = bool
        })
  })
  description = "Deatils of SQL Instance"
}

variable "private_network" {
  type = string
}
