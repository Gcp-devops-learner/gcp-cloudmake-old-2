resource "google_project_iam_binding" "artifact_repo_admin" {
  role    = "roles/artifactregistry.repoAdmin"
  project = var.project_id
  members = var.list_of_accounts_artifact_admin
}

resource "google_project_iam_binding" "artifact_repo_reader" {
  role    = "roles/artifactregistry.reader"
  project = var.project_id
  members = var.list_of_accounts_artifact_readonly
}
