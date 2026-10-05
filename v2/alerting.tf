resource "google_monitoring_notification_channel" "email" {
  display_name = "CloudLab Email"
  type         = "email"

  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_alert_policy" "mig_cpu" {
  display_name = "MIG High CPU Usage"
  combiner     = "OR"

  conditions {
    display_name = "CPU utilization > 80%"

    condition_threshold {
      filter          = "resource.type = \"gce_instance\" AND metric.type = \"compute.googleapis.com/instance/cpu/utilization\""
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }

      trigger {
        count = 1
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.name]

  alert_strategy {
    auto_close = "1800s"
  }
}

resource "google_monitoring_alert_policy" "lb_latency" {
  display_name = "LB High Latency"
  combiner     = "OR"

  conditions {
    display_name = "Backend latency > 2s"

    condition_threshold {
      filter          = "resource.type = \"https_lb_rule\" AND resource.labels.url_map_name = \"nginx-url-map\" AND metric.type = \"loadbalancing.googleapis.com/https/backend_latencies\""
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 2000

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_PERCENTILE_95"
      }

      trigger {
        count = 1
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.name]

  alert_strategy {
    auto_close = "1800s"
  }
}
