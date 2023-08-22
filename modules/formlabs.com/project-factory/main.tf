module "gcp_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 13.1"

  name              = var.project_name
  org_id            = local.org_ids["formlabs_com"]
  folder_id         = var.folder_id
  random_project_id = true

  activate_apis           = concat(var.activate_apis, local.default_apis)
  activate_api_identities = var.activate_api_identities

  billing_account = var.billing_account != "" ? var.billing_account : local.billing_account_ids["formlabs_master"]

  labels = merge(
    local.common_labels,
    var.labels
  )
}
