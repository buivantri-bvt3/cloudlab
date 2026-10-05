variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "cloudlab-vm"
}

variable "vm_machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-micro"
}

variable "alert_email" {
  description = "Email for alerting notifications"
  type        = string
}
