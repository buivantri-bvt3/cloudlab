resource "google_monitoring_notification_channel" "email" {
  display_name = "CloudLab Email"
  type         = "email"

  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_alert_policy" "vm_uptime" {
  display_name = "VM Instance Uptime"
  combiner     = "OR"

  conditions {
    display_name = "VM is not running"

    condition_threshold {
      filter          = "resource.type = \"gce_instance\" AND resource.labels.instance_id = \"${google_compute_instance.vm.instance_id}\" AND metric.type = \"compute.googleapis.com/instance/uptime\""
      duration        = "300s"
      comparison      = "COMPARISON_LT"
      threshold_value = 1

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_RATE"
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

resource "google_monitoring_alert_policy" "vm_cpu" {
  display_name = "VM High CPU Usage"
  combiner     = "OR"

  conditions {
    display_name = "CPU utilization > 80%"

    condition_threshold {
      filter          = "resource.type = \"gce_instance\" AND resource.labels.instance_id = \"${google_compute_instance.vm.instance_id}\" AND metric.type = \"compute.googleapis.com/instance/cpu/utilization\""
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

resource "google_monitoring_alert_policy" "vm_disk" {
  display_name = "VM High Disk Usage"
  combiner     = "OR"

  conditions {
    display_name = "Disk utilization > 90%"

    condition_threshold {
      filter          = "resource.type = \"gce_instance\" AND resource.labels.instance_id = \"${google_compute_instance.vm.instance_id}\" AND metric.type = \"agent.googleapis.com/disk/percent_used\" AND metric.labels.state = \"used\""
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 90

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
