output "project_id" {
  description = "GCP Project ID"
  value       = var.project_id
}

output "region" {
  description = "GCP region"
  value       = var.region
}

output "lb_ip" {
  description = "Load Balancer external IP"
  value       = google_compute_global_address.nginx.address
}

output "mig_name" {
  description = "Managed Instance Group name"
  value       = google_compute_instance_group_manager.nginx.name
}
