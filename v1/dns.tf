resource "google_dns_managed_zone" "private" {
  name        = "private-zone"
  dns_name    = "cloudlab.internal."
  description = "Private DNS zone for CloudLab"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = data.google_compute_network.default.id
    }
  }

  depends_on = [google_project_service.dns]
}

resource "google_dns_record_set" "vm" {
  name         = "vm.cloudlab.internal."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.private.name
  rrdatas      = [google_compute_instance.vm.network_interface[0].network_ip]
}

data "google_compute_network" "default" {
  name = "default"
}
