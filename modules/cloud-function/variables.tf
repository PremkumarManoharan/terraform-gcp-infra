variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "runtime" {
  type= string
}
variable "entry_point" {
  type= string
}
variable "bucket" {
  type= string
}
variable "object" {
  type= string
}
variable "SENDGRID_API_KEY" {
  type= string
}
variable "PG_USER" {
  type= string
}
variable "PG_HOST" {
  type= string
}
variable "PG_DB" {
  type= string
}
variable "PG_PASSWORD" {
  type= string
}
variable "vpc_connector" {
  type= string
}
variable "max_instance_count" {
  type= number
}
variable "min_instance_count" {
  type= number
}
variable "available_memory" {
  type= string
}
variable "available_cpu" {
  type= string
}
variable "timeout_seconds" {
  type= number
}
variable "ingress_settings" {
  type= string
}
variable "all_traffic_on_latest_revision" {
  type= bool
}
variable "event_type" {
  type= string
}
variable "pubsub_topic" {
  type= string
}
variable "retry_policy" {
  type= string
}
variable "vpc_connector_egress_settings" {
  type= string
}
variable "service_account_email_functions" {
  type= string
}
variable "service_account_email_pubsub" {
  type= string
}
variable "generation" {
  type= string
}
