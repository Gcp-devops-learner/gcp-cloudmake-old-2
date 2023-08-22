module "terraform_project" {
  # checkov:skip=CKV_GCP_49
  # checkov:skip=CKV_GCP_62
  # checkov:skip=CKV_GCP_78
  # checkov:skip=CKV2_GCP_5
  source = "../../modules/formlabs.com/project-factory"

  project_name = "terraform"
  folder_id    = local.folder_ids["devops_prod"]

  activate_apis = [
    "container.googleapis.com"
  ]

  labels = {
    environment = "prod"
    owner       = "devops"
    project     = "terraform"
  }
}

module "k8s_test_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "k8s-test"
  folder_id    = local.folder_ids["devops_dev"]

  activate_apis = [
    "container.googleapis.com"
  ]

  labels = {
    environment = "dev"
    owner       = "devops"
    project     = "k8s-test"
  }
}

module "prod_network_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "prod-network"
  folder_id    = local.folder_ids["devops_prod"]

  labels = {
    environment = "prod"
    owner       = "devops"
    project     = "network"
  }
}

module "dev_network_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "dev-network"
  folder_id    = local.folder_ids["devops_dev"]

  labels = {
    environment = "dev"
    owner       = "devops"
    project     = "network"
  }
}

module "prod_vpn_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "prod-aws-vpn"
  folder_id    = local.folder_ids["devops_prod"]

  labels = {
    environment = "prod"
    owner       = "devops"
    project     = "network"
  }
}

module "dev_vpn_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "dev-aws-vpn"
  folder_id    = local.folder_ids["devops_dev"]

  labels = {
    environment = "dev"
    owner       = "devops"
    project     = "network"
  }
}

module "dev_cloudlogging_system_test_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "k8s-test"
  folder_id    = local.folder_ids["systems_dev"]

  activate_apis = [
    "logging.googleapis.com"
  ]

  labels = {
    environment = "dev"
    owner       = "systems"
    project     = "cloudlogging-test"
  }
}

module "jenkins_packer_project" {
  # checkov:skip=CKV_GCP_49
  # checkov:skip=CKV_GCP_62
  # checkov:skip=CKV_GCP_78
  # checkov:skip=CKV2_GCP_5
  source = "../../modules/formlabs.com/project-factory"

  project_name = "jenkins-packer"
  folder_id    = local.folder_ids["devops_dev"]

  activate_apis = [
    "sourcerepo.googleapis.com",
    "compute.googleapis.com",
    "servicemanagement.googleapis.com",
    "storage-api.googleapis.com",
    "cloudbuild.googleapis.com",
    "servicenetworking.googleapis.com",
  ]

  labels = {
    environment = "prod"
    owner       = "devops"
    project     = "jenkins"
  }
}

module "dev_formlabs_cloud_sandbox_project" {
  #checkov:skip=CKV_GCP_49
  #checkov:skip=CKV_GCP_62
  #checkov:skip=CKV_GCP_78
  #checkov:skip=CKV2_GCP_5
  source = "../../modules/formlabs.com/project-factory"

  project_name = "formlabs-cloud-sandbox"
  folder_id    = local.folder_ids["software_dev"]

  labels = {
    environment = "dev"
    owner       = "engineering"
    project     = "formlabs-cloud-sandbox"
  }
}

module "formlabs_repo_dev_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "formlabs-repo-dev"
  folder_id    = local.folder_ids["devops_dev"]

  activate_apis = [
    "artifactregistry.googleapis.com"
  ]

  labels = {
    environment = "dev"
    owner       = "devops"
    project     = "formlabs-repo-dev"
  }
}

module "embedded_build_machines_dev_project" {
  source = "../../modules/formlabs.com/project-factory"

  project_name = "embedded-build-machines"
  folder_id    = local.folder_ids["software_dev"]

  activate_apis = [
    "sourcerepo.googleapis.com",
    "compute.googleapis.com",
    "servicemanagement.googleapis.com",
    "storage-api.googleapis.com",
    "cloudbuild.googleapis.com",
    "servicenetworking.googleapis.com",
  ]

  labels = {
    environment = "dev"
    owner       = "engineering"
    project     = "embedded-build-machines"
  }
}
