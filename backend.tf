terraform {
 backend "gcs" {
   bucket  = "infra_terraform_backend"
   prefix  = "terraform/state"
 }
}
