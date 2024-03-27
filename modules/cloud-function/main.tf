resource "google_cloudfunctions2_function" "cloud_functions" {
  name        = var.name 
  location    = var.location

  build_config {
    runtime     = var.runtime 
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.bucket
        object = var.object
      }
    }
  }

  service_config {
    environment_variables = {
      SENDGRID_API_KEY             = var.SENDGRID_API_KEY
      PG_USER                      = var.PG_USER  
      PG_HOST                      = var.PG_HOST 
      PG_DB                        = var.PG_DB
      PG_PASSWORD                  = var.PG_PASSWORD
    }              
    vpc_connector                  = var.vpc_connector 
    max_instance_count             = var.max_instance_count 
    min_instance_count             = var.min_instance_count
    available_memory               = var.available_memory
    available_cpu                  = var.available_cpu
    timeout_seconds                = var.timeout_seconds 
    ingress_settings               = var.ingress_settings
    all_traffic_on_latest_revision = var.all_traffic_on_latest_revision
    vpc_connector_egress_settings  = var.vpc_connector_egress_settings
    service_account_email          = var.service_account_email_functions
  }

  event_trigger {
    event_type               = var.event_type
    pubsub_topic             = var.pubsub_topic
    retry_policy             = var.retry_policy
    service_account_email          = var.service_account_email_pubsub
  }
}
