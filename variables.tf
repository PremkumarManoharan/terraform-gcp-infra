
variable "region" {
  type        = string
  description = "GCP region for all resources."
  default = "us-east1"
}

variable "project_name" {
  type        = string
  description = "Name of the example project."
  default = "csye-6225-dev-413816"
}
