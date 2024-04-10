variable "name" {
  type = string
}
variable "description" {
  type = string
}
variable "tags" {
  type = list(string)
}
variable "machine_type" {
  type = string
}
variable "disk_type" {
  type = string
}
variable "disk_size_gb" {
  type = number
}
variable "subnetwork" {
  type = string
}
variable "network_tier" {
  type = string
}
variable "scopes" {
  type = list(string)
}
variable "dbhostname" {
  type = string
}
variable "dbuser" {
  type = string
}
variable "dbpassword" {
  type = string
}
variable "database" {
  type = string
}
variable "pubsubtopic" {
  type = string
}
variable "email" {
  type = string
}
variable "family" {
  type = string
}
variable "family_project" {
  type = string
}
variable "kms_key_self_link" {
  type = string
}
variable "kms_key_service_account" {
  type = string
}
