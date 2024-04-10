
variable "sql_instance" {
  type        = object({
    sql_instance_name      = string
    database_version       = string
    tier                   = string
    availability_type      = optional(string,"REGIONAL")
    disk_size              = optional(number,100)
    disk_type              = optional(string,"PD_SSD")
    ipv4_enabled           = optional(bool,false)
    edition                = string
    vpc_name               = string
    deletion_protection_enabled = optional(bool,false)
    database               = object({
            name = string
            username = string
            password_length = number
            password_special = bool
        })
  })
  description = "Deatils of SQL Instance"
}

variable "private_network" {
  type = string
}

variable "encryption_key_name" {
  type = string
}
