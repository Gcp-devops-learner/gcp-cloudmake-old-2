resource "google_project_iam_custom_role" "cloud_builder" {
  role_id     = "cloudBuilder"
  title       = "Cloud Build Role"
  description = "A custom role which grants access to cloud build and associated policies"
  permissions = [
    # Required to push packer builder image to container registry
    "artifactregistry.repositories.uploadArtifacts",
    "artifactregistry.repositories.list",
    "artifactregistry.repositories.get",
    "artifactregistry.repositories.downloadArtifacts",
    "artifactregistry.files.list",
    "artifactregistry.files.get",
    "artifactregistry.packages.list",
    "artifactregistry.packages.get",
    "artifactregistry.tags.create",
    "artifactregistry.tags.update",
    "artifactregistry.tags.list",
    "artifactregistry.tags.get",
    "artifactregistry.versions.list",
    "artifactregistry.versions.get",

    # Required to be able store created builds
    "storage.buckets.create",
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.objects.list",
    "storage.objects.update",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",

    # Required to create and update cloud builds
    "cloudbuild.builds.create",
    "cloudbuild.builds.update",
    "cloudbuild.builds.list",
    "cloudbuild.builds.get",

    # Required to create image and set image labels
    "compute.images.create",
    "compute.images.setLabels",

    # Required to be able to generate logs 
    "logging.logEntries.create",

    # Required to impersonate service account
    "iam.serviceAccounts.actAs",

    # Required to use worker pool
    "cloudbuild.workerpools.use",
  ]
}

resource "google_project_iam_custom_role" "jenkins" {
  role_id     = "jenkinsCasc"
  title       = "Jenkins"
  description = "A custom role made for Jenkins which grants an account access to provision compute nodes"
  permissions = [
    "iam.serviceAccounts.actAs",
  ]
}

resource "google_service_account" "cloud_build_service_account" {
  account_id   = "cloud-build"
  display_name = "Cloud build service account"
  description  = "Custom cloud build service account"
}

resource "google_project_iam_binding" "jenkins" {
  role    = google_project_iam_custom_role.jenkins.name
  project = local.project_id
  members = [
    google_service_account.jenkins_service_account.member,
  ]
}

resource "google_project_iam_binding" "cloud_build_builder" {
  role    = google_project_iam_custom_role.cloud_builder.name
  project = local.project_id
  members = [
    google_service_account.cloud_build_service_account.member,
  ]
}

resource "google_project_iam_binding" "cloud_build_instance_admin" {
  role    = "roles/compute.instanceAdmin"
  project = local.project_id
  members = [
    google_service_account.cloud_build_service_account.member,
    google_service_account.jenkins_service_account.member,
  ]
}

resource "google_service_account_key" "cloud_build_service_account_key" {
  service_account_id = google_service_account.cloud_build_service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_service_account_key" "jenkins_service_account_key" {
  service_account_id = google_service_account.jenkins_service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_service_account" "jenkins_service_account" {
  account_id   = "jenkins"
  display_name = "Jenkins service account"
  description  = "Custom Jenkins service account"
}
