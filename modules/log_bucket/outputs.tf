output "name" {
  description = "Name of the log bucket"
  value       = google_storage_bucket.log_bucket.name
}

output "url" {
  description = "URL of the log bucket"
  value       = "gs://${google_storage_bucket.log_bucket.name}"
}
