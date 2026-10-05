resource "google_compute_instance_template" "nginx" {
  name_prefix  = "nginx-"
  machine_type = var.vm_machine_type
  region       = var.region

  disk {
    source_image = "nginx"
    disk_size_gb = 20
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"

    access_config {}
  }

  tags = ["http-server", "https-server"]

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [google_project_service.compute]
}

resource "google_compute_health_check" "http" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}

resource "google_compute_instance_group_manager" "nginx" {
  name               = "nginx-mig"
  base_instance_name = "nginx"
  zone               = var.zone
  target_size        = var.mig_size

  version {
    instance_template = google_compute_instance_template.nginx.self_link_unique
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http.id
    initial_delay_sec = 120
  }

  update_policy {
    type                           = "PROACTIVE"
    minimal_action                 = "REPLACE"
    most_disruptive_allowed_action = "REPLACE"
    max_surge_fixed                = 1
    max_unavailable_fixed          = 0
  }
}
