resource "google_service_account" "atlantis" {
  account_id   = "atlantis"
  display_name = "Atlantis"
}

resource "google_service_account_key" "atlantis" {
  service_account_id = google_service_account.atlantis.name
}

resource "google_organization_iam_member" "atlantis_owner" {
  #checkov:skip=CKV_GCP_45: Skip it because atlantis is needed to be create new projects
  #checkov:skip=CKV_GCP_115: Ensure basic roles are not used at organization level.
  org_id = local.org_ids["formlabs_com"]
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.atlantis.email}"
}

resource "google_organization_iam_member" "atlantis_org" {
  #checkov:skip=CKV_GCP_45: Skip it because atlantis is needed manage iams
  org_id = local.org_ids["formlabs_com"]
  role   = "roles/resourcemanager.organizationAdmin"
  member = "serviceAccount:${google_service_account.atlantis.email}"
}

resource "google_organization_iam_member" "atlantis_project" {
  #checkov:skip=CKV_GCP_45: Skip it because atlantis is needed create project
  org_id = local.org_ids["formlabs_com"]
  role   = "roles/resourcemanager.projectCreator"
  member = "serviceAccount:${google_service_account.atlantis.email}"
}

resource "google_organization_iam_member" "atlantis_xpn" {
  #checkov:skip=CKV_GCP_45: Skip it because atlantis is needed manage shared vpcs
  org_id = local.org_ids["formlabs_com"]
  role   = "roles/compute.xpnAdmin"
  member = "serviceAccount:${google_service_account.atlantis.email}"
}

resource "google_organization_iam_member" "atlantis_network" {
  #checkov:skip=CKV_GCP_45: Skip it because atlantis is needed manage shared vpcs
  org_id = local.org_ids["formlabs_com"]
  role   = "roles/compute.networkAdmin"
  member = "serviceAccount:${google_service_account.atlantis.email}"
}
