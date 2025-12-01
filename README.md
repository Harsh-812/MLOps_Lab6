# Lab 6 – Terraform on GCP

## Overview

This lab uses Terraform to create and manage a small Google Cloud setup for a test project.  
The configuration creates:

- A Compute Engine VM
- A main Cloud Storage bucket
- An additional Cloud Storage bucket created through a Terraform module
- A separate Cloud Storage bucket used only for **remote Terraform state** (created manually in the console)

All infrastructure (except the remote state bucket) is created and destroyed with Terraform.

---

## Learning goals

- Use Terraform to define and manage GCP resources (VM + storage buckets).
- Understand how to use variables, validation, and outputs.
- Configure a GCS backend to store Terraform state remotely.
- Create and use a simple Terraform module.
- Practice the full lifecycle: `plan → apply → update → destroy`.

---

## Modifications / Additions 

- Used multiple files and variables instead of hardcoding values:
  - `main.tf` (root config)
  - `variables.tf` (inputs + validation)
  - `outputs.tf` (useful outputs)
  - `terraform.tfvars` (actual values, not committed)
- Added **variable validation blocks** for project ID, region, zone, instance name, and bucket names to catch bad input early.
- Used the `random_id` resource to generate a unique main bucket name instead of a fixed string.
- Added a startup script on the VM using `metadata_startup_script` to write a simple file on boot.
- Changes the VM machine type and labels and handles the GCP error by setting  
  `allow_stopping_for_update = true` so Terraform can stop and restart the instance when updating.
- Configured a GCS backend (`backend "gcs"`) so Terraform state is stored in a dedicated state bucket instead of a local file.
- Added a child module (`modules/log_bucket`) that creates an extra “log” bucket, called from the root with `module "log_bucket"`.
- Exposed outputs for:
  - VM external IP
  - Main bucket name and URL
  - Module bucket name and URL

## Terraform Commands Used

- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply
- terraform destroy

---
