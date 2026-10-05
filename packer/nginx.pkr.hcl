packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.0.0"
    }
  }
}

variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

source "googlecompute" "nginx" {
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  source_image = "debian-12-bookworm-v20241009"
  source_image_family = "debian-12"
  image_name   = "nginx-{{timestamp}}"
  image_family = "nginx"
  machine_type = "e2-micro"
  disk_size    = 20
  ssh_username = "packer"
}

build {
  sources = ["source.googlecompute.nginx"]

  provisioner "ansible" {
    playbook_file = "${path.root}/ansible/playbook.yml"
    extra_arguments = ["-e", "ansible_remote_tmp=/tmp/.ansible/tmp"]
  }
}
