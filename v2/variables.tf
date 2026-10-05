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

variable "vm_machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-micro"
}

variable "mig_size" {
  description = "Number of instances in the MIG"
  type        = number
  default     = 1
}

variable "alert_email" {
  description = "Email for alerting notifications"
  type        = string
}
