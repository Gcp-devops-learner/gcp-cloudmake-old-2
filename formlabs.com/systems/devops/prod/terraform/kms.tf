resource "google_kms_key_ring" "devops" {
  name     = "keyring-devops"
  location = "us-east1"
}

resource "google_kms_crypto_key" "terrafrom_state" {
  #checkov:skip=CKV_GCP_43: Skip key rotating
  name     = "terraform-state"
  key_ring = google_kms_key_ring.devops.id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_binding" "binding" {
  crypto_key_id = google_kms_crypto_key.terrafrom_state.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:${google_service_account.atlantis.email}",
    "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}",
  ]
}
