output "cloud_build_service_account_key" {
  value     = google_service_account_key.cloud_build_service_account_key.private_key
  sensitive = true
}

output "jenkins_service_account_key" {
  value     = google_service_account_key.jenkins_service_account_key.private_key
  sensitive = true
}
