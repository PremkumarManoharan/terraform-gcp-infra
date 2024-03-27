
variable "name" {
  type        = string
  description = "Name of VM Instance"
}
variable "email" {
  type = string
}

variable "scopes" {
  type = list(string)
}

variable "machine_type" {
  type        = string
  description = "VM Instance machine_type"
}
variable "zone" {
  type        = string
  description = "Name of zone"
}

variable "tags" {
  type        = list(string)
  description = "tags for VM Instance"
}

variable "family" {
  type        = string
  description = "Image Family of VM Instance"
}

variable "family_project" {
  type        = string
  description = "Project of Image Family of VM Instance"
}

variable "size" {
  type        = string
  description = "Size of VM Instance image"
}

variable "type" {
  type        = string
  description = "Type of disk"
}

variable "subnet" {
  type        = string
  description = "Name of Subnet"
}

variable "network_tier" {
  type        = string
  description = "Network_tier for public Ip"
}
variable "dbhostname" {
  type        = string
  description = "DB hostname for private connection"
}
variable "dbpassword" {
  type        = string
  description = "DB password for private connection"
}
variable "dbuser" {
  type        = string
  description = "DB username for private connection"
}
variable "database" {
  type        = string
  description = "DB name for private connection"
}
variable "pubsubtopic" {
  type        = string
  description = "Topic name to publish message to send email"
}
