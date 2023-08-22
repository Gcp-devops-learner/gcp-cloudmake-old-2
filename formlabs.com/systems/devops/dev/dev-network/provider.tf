provider "google" {
  project = local.project_id
  region  = "us-east1"
}

provider "google-beta" {
  project = local.project_id
  region  = "us-east1"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = "Dev"
      Owner       = "DevOps"
      Project     = "Network"
      Provisioner = "Terraform"
    }
  }
}
