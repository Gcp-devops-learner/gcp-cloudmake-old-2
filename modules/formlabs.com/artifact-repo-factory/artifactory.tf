resource "google_artifact_registry_repository" "artifact_repo" {
  # checkov:skip=CKV_GCP_84
  location      = var.region
  repository_id = var.repository_id
  description   = var.description
  project       = var.project_id
  format        = "DOCKER"
}
