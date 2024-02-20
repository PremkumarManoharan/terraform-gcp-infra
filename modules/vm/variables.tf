
variable "name" {
  type        = string
  description = "Name of VM Instance"
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

variable "image" {
  type        = string
  description = "Image of VM Instance"
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
