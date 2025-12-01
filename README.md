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

### Terraform aaply (initial create)

<img width="540" height="144" alt="image" src="https://github.com/user-attachments/assets/9a66d46a-5dad-48ea-9a98-69e6f4d5af51" />

### VM in GCP

<img width="540" height="75" alt="image" src="https://github.com/user-attachments/assets/6a1b0380-9766-47cf-8c70-3fd8eb0424c5" />

<img width="431" height="200" alt="image" src="https://github.com/user-attachments/assets/cef91f54-0db3-4dd0-a3ea-5aecc4ad1823" />

### Modifying Resources (machine type, labels and added "allow_stopping_for_update")

<img width="396" height="324" alt="image" src="https://github.com/user-attachments/assets/614844ee-96af-40b8-b0b4-5696043f4fdb" />

<img width="434" height="95" alt="image" src="https://github.com/user-attachments/assets/82beb50e-3a6a-4746-8031-edca80d50f28" />

### Buckets in GCP

<img width="900" height="250" alt="image" src="https://github.com/user-attachments/assets/83754903-2de4-4e33-b71f-4d9f96a88844" />

### Destroying Resources

<img width="928" height="213" alt="image" src="https://github.com/user-attachments/assets/f2f0ea25-47d3-44f1-a045-4d779601ed72" />


---
