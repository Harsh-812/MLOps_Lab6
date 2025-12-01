variable "project_id" {
  description = "GCP project ID"
  type        = string

  validation {
    condition     = length(var.project_id) > 0
    error_message = "project_id must not be empty."
  }
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"

  validation {
    condition = contains([
      "us-central1",
      "us-east1",
      "us-west1"
    ], var.region)

    error_message = "region must be one of: us-central1, us-east1, us-west1."
  }
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"

  validation {
    condition     = startswith(var.zone, "${var.region}-")
    error_message = "zone must belong to the selected region (e.g. us-central1-a for us-central1)."
  }
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "lab6-vm"

  validation {
    condition     = length(var.instance_name) > 3
    error_message = "instance_name must be at least 4 characters long."
  }
}

variable "bucket_prefix" {
  description = "Prefix to use for the storage bucket"
  type        = string
  default     = "lab6-tf-bucket"

  validation {
    condition = (
      length(var.bucket_prefix) >= 3 &&
      length(var.bucket_prefix) <= 30 &&
      can(regex("^[a-z0-9-]+$", var.bucket_prefix))
    )

    error_message = "bucket_prefix must be 3–30 characters, lowercase letters, numbers, and hyphens only."
  }
}

variable "log_bucket_name" {
  description = "Name for the extra log bucket created via the module"
  type        = string

  validation {
    condition = (
      length(var.log_bucket_name) >= 3 &&
      length(var.log_bucket_name) <= 60 &&
      can(regex("^[a-z0-9_.-]+$", var.log_bucket_name))
    )
    error_message = "log_bucket_name must be 3–60 chars, lowercase letters, numbers, dashes, underscores, or dots."
  }
}

