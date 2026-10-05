terraform {
  required_version = ">= 1.0"

  backend "gcs" {
    bucket = "user-mmbbjxxwjpbv-tfstate"
    prefix = "terraform/v1"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
