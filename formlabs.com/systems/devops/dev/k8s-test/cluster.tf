module "cluster" {
  source = "../../../../../modules/formlabs.com/kubernetes-factory"

  project_id         = local.project_id
  cluster_name       = "k8s-test"
  kubernetes_version = "1.25.6-gke.1000"
  machine_types      = ["e2-standard-2"]

  labels = local.labels
}
