variable "dns_zone_name" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "record_type" {
  type = string
}
variable "record_ttl" {
  type = number
}
variable "record_rrdatas" {
  type = list(string)
}
