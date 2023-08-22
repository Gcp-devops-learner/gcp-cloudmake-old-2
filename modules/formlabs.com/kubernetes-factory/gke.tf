data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "25.0.0"

  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.cluster_region
  zones                      = var.cluster_zones
  network                    = module.vpc.gcp_vpc_name
  subnetwork                 = local.network_names["subnet"]
  ip_range_pods              = local.network_names["pods"]
  ip_range_services          = local.network_names["services"]
  master_authorized_networks = var.master_authorized_networks
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = true
  kubernetes_version         = var.kubernetes_version
  release_channel            = "UNSPECIFIED"
  logging_service            = "logging.googleapis.com/kubernetes"
  monitoring_service         = "monitoring.googleapis.com/kubernetes"
  remove_default_node_pool   = true
  node_pools                 = local.node_pools
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  cluster_resource_labels = local.labels

  depends_on = [module.vpc.gcp_vpc_subnets]
}
