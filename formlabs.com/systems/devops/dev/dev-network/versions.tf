terraform {
  required_version = "1.3.8"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.52"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.52"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.54"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}
