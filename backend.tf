terraform {
  backend "gcs" {
    bucket = "formlabs-terraform-gcp-state"
  }
}
