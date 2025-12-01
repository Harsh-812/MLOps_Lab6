variable "bucket_name" {
  description = "Name for the log bucket (must be globally unique)"
  type        = string
}

variable "location" {
  description = "Bucket location"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment label"
  type        = string
  default     = "lab"
}
