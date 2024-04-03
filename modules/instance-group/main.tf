resource "google_compute_region_autoscaler" "autoscaler" {
  name   = var.autoscaling.name
  target = google_compute_region_instance_group_manager.igm.id

  autoscaling_policy {
    max_replicas    = var.autoscaling.max_replicas
    min_replicas    = var.autoscaling.min_replicas
    cooldown_period = var.autoscaling.cooldown_period

    cpu_utilization {
      target = var.autoscaling.cpu_util_target
    }
    scale_in_control{
        max_scaled_in_replicas {
          fixed = var.autoscaling.max_scaled_in_replicas_fixed #1
        }
        time_window_sec = var.autoscaling.scale_in_control_time_window_sec #60
    }
  }
}

resource "google_compute_health_check" "http-health-check" {
  name        = var.http-health-check.name
  description = var.http-health-check.description

  timeout_sec         = var.http-health-check.timeout_sec
  check_interval_sec  = var.http-health-check.check_interval_sec
  healthy_threshold   = var.http-health-check.healthy_threshold
  unhealthy_threshold = var.http-health-check.unhealthy_threshold


  http_health_check {
    port_name          = var.http-health-check.port_name
    port               = var.http-health-check.port
    request_path       = var.http-health-check.request_path
  }
}

resource "google_compute_region_instance_group_manager" "igm" {
  name   = var.igm.name
  

  version {
    instance_template  = var.instance_template_id
    name               = var.igm.version_name
  }
  named_port {
    name = var.igm.port_name
    port = var.igm.port
  }

  auto_healing_policies{
    health_check = google_compute_health_check.http-health-check.self_link
    initial_delay_sec = var.igm.initial_delay_sec
  }

  instance_lifecycle_policy {
  force_update_on_repair    = var.igm.force_update_on_repair
  default_action_on_failure = var.igm.default_action_on_failure
}

  base_instance_name = var.igm.base_instance_name
}
