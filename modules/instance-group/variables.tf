variable "instance_template_id" {
  type = string
}
variable "autoscaling" {
  type = object({
    name                             = string
    max_replicas                     = number
    min_replicas                     = number
    cooldown_period                  = number
    cpu_util_target                  = number
    max_scaled_in_replicas_fixed     = number
    scale_in_control_time_window_sec = number
  })
}

variable "http-health-check" {
  type = object({
    name                = string
    description         = string
    timeout_sec         = number
    check_interval_sec  = number
    healthy_threshold   = number
    unhealthy_threshold = number
    port_name           = string
    port                = number
    request_path        = string
  })
}

variable "igm" {
  type = object({
    name                      = string
    base_instance_name        = string
    version_name              = string
    port_name                 = string
    port                      = number
    initial_delay_sec         = number
    force_update_on_repair    = string
    default_action_on_failure = string
  })
}
