module "artifact_repo" {
  source = "../../../../../modules/formlabs.com/artifact-repo-factory"

  project_id    = local.project_id
  region        = local.region
  repository_id = "formlabs-dev-repo"
  description   = "This repository is Formlabs dev environment's main artifact repo."

  list_of_accounts_artifact_admin = [
    "group:gcp-devops@formlabs.com"
  ]
}
