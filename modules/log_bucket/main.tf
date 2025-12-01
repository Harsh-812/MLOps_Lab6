resource "google_storage_bucket" "log_bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true

  labels = {
    environment = var.environment
    purpose     = "module-example"
  }
}
