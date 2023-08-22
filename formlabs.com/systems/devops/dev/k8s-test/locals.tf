locals {
  project_id = "k8s-test-cae4"

  labels = merge(
    local.common_labels,
    {
      environment = "dev"
      owner       = "devops"
      project     = "k8s-test"
    }
  )
}
