terraform {
  required_version = ">= 1.0"

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
}

resource "google_storage_bucket" "tfstate" {
  name          = "${var.project_id}-tfstate"
  location      = var.region
  force_destroy = true

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}
