output "project_id" {
  description = "GCP Project ID"
  value       = var.project_id
}

output "region" {
  description = "GCP region"
  value       = var.region
}

output "vm_name" {
  description = "VM instance name"
  value       = google_compute_instance.vm.name
}

output "vm_external_ip" {
  description = "VM external IP address"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
