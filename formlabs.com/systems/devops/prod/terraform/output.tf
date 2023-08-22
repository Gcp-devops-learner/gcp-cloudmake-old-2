output "atlantis_public_key" {
  value     = google_service_account_key.atlantis.public_key
  sensitive = true
}

output "atlantis_private_key" {
  value     = google_service_account_key.atlantis.private_key
  sensitive = true
}
