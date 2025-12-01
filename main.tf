terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  backend "gcs" {
    bucket = "lab6-tf-state-479820"
    prefix = "lab6/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "log_bucket" {
  source      = "./modules/log_bucket"
  bucket_name = var.log_bucket_name
  location    = var.region
  environment = "lab"
}


# VM INSTANCE 
resource "google_compute_instance" "lab_vm" {
  name         = var.instance_name
  machine_type = "e2-small"

  allow_stopping_for_update = true

  labels = {
    environment = "dev"
    owner       = "harshitha"
    lab         = "lab6"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 12
    }
  }

  network_interface {
    network = "default"

    # External IP so we can reach it
    access_config {}
  }

  # Extra bit vs professor: startup script
  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Hello from Terraform Lab 6" > /tmp/terraform-lab6.txt
  EOT
}

# RANDOM SUFFIX FOR BUCKET 
resource "random_id" "bucket_suffix" {
  byte_length = 2
}

# STORAGE BUCKET 
resource "google_storage_bucket" "lab_bucket" {
  name          = "${var.bucket_prefix}-${random_id.bucket_suffix.hex}"
  location      = var.region
  force_destroy = true

  labels = {
    environment = "lab"
  }
}
