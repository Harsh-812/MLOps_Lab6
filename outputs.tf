output "vm_external_ip" {
  description = "External IP of the lab VM"
  value       = google_compute_instance.lab_vm.network_interface[0].access_config[0].nat_ip
}

output "bucket_name" {
  description = "Name of the storage bucket created by Terraform"
  value       = google_storage_bucket.lab_bucket.name
}

output "bucket_url" {
  description = "GS URL of the bucket"
  value       = "gs://${google_storage_bucket.lab_bucket.name}"
}

output "log_bucket_name" {
  description = "Name of the extra log bucket created via module"
  value       = module.log_bucket.name
}

output "log_bucket_url" {
  description = "URL of the extra log bucket"
  value       = module.log_bucket.url
}

