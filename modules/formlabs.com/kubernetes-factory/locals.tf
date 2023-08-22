locals {
  network_names = {
    subnet   = "${var.cluster_name}-subnet-01"
    pods     = "${var.cluster_name}-subnet-01-pods-01"
    services = "${var.cluster_name}-subnet-01-services-01"
  }

  node_pools = [
    for type in var.machine_types : {
      name                   = "${var.cluster_name}-${type}-node-pool"
      machine_type           = type
      node_locations         = join(",", var.cluster_zones)
      min_count              = var.cluster_min_node
      max_count              = var.cluster_max_node
      spot                   = false
      disk_size_gb           = var.disk_size_gb
      disk_type              = "pd-balanced"
      image_type             = "COS_CONTAINERD"
      enable_gcfs            = true
      enable_gvnic           = false
      auto_repair            = true
      auto_upgrade           = false
      create_service_account = true
      preemptible            = false
      initial_node_count     = 0
    }
  ]

  labels = merge(
    local.common_labels,
    var.labels
  )
}
