resource "google_compute_instance" "vm" {
  depends_on = [google_project_service.compute]

  name                      = var.vm_name
  allow_stopping_for_update = true
  machine_type              = var.vm_machine_type
  zone                      = var.zone

  boot_disk {
    initialize_params {
      image = "nginx"
      size  = 20
    }
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
}
