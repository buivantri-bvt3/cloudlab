resource "google_compute_backend_service" "nginx" {
  name                  = "nginx-backend"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  health_checks         = [google_compute_health_check.http.id]
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_instance_group_manager.nginx.instance_group
  }
}

resource "google_compute_url_map" "nginx" {
  name            = "nginx-url-map"
  default_service = google_compute_backend_service.nginx.id
}

resource "google_compute_target_http_proxy" "nginx" {
  name    = "nginx-http-proxy"
  url_map = google_compute_url_map.nginx.id
}

resource "google_compute_global_address" "nginx" {
  name = "nginx-lb-ip"
}

resource "google_compute_global_forwarding_rule" "nginx" {
  name                  = "nginx-forwarding-rule"
  target                = google_compute_target_http_proxy.nginx.id
  port_range            = "80"
  ip_address            = google_compute_global_address.nginx.address
  load_balancing_scheme = "EXTERNAL"
}
