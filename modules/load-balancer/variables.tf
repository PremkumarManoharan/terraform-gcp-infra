variable "backend-group" {
  type = string
}
variable "project" {
  type = string
}
variable "name" {
  type = string
}
variable "ssl" {
  type = bool
}
variable "managed_ssl_certificate_domains" {
  type = list(string)
}
variable "backend_port" {
  type = number
}
variable "backend_port_name" {
  type = string
}
variable "backend_protocol" {
  type = string
}
variable "firewall_networks" {
  type = list(string)
}
variable "backend_timeoout_sec" {
  type = number
}
variable "enable_cdn" {
  type = bool
}
variable "log_config_enable" {
  type = bool
}
variable "health_check_request_path" {
  type = string
}
variable "health_check_port" {
  type = number
}
variable "iap_config_enable" {
  type = bool
}
variable "target_tags" {
  type = list(string)
}
variable "http_forward" {
  type = bool
}
