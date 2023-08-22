module "terraform_project" {
  # checkov:skip=CKV_GCP_76 IPV6 not used
  # checkov:skip=CKV_GCP_74 Subnet private access already enabled
  source       = "../../../../../modules/vpc-factory"
  project_id   = local.project_id
  network_name = "jenkins-packer"
  subnets = [
    {
      subnet_name           = "jenkins-packer-01"
      subnet_ip             = "10.235.5.0/24"
      subnet_region         = "us-east1"
      subnet_private_access = "true"
    }
  ]
  firewall_rules = [
    {
      name        = "allow-winrm-ssl"
      direction   = "INGRESS"
      ranges      = ["10.0.0.0/8"]
      target_tags = ["win-rm"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["5986"]
        }
      ]
    },
    {
      # Allow RDP from WARP
      name        = "allow-jenkins-rdp"
      direction   = "INGRESS"
      ranges      = ["54.157.209.135/32"]
      target_tags = ["jenkins-agent"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["3389"]
        }
      ]
    },
    {
      name        = "allow-internet"
      direction   = "EGRESS"
      ranges      = ["10.0.0.0/8"]
      target_tags = ["win-rm"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["80"]
        }
      ]
    },
    {
      name        = "allow-internet-ssl"
      direction   = "EGRESS"
      ranges      = ["10.0.0.0/8"]
      target_tags = ["win-rm"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["443"]
        }
      ]
    }
  ]
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.235.6.0"
  prefix_length = 24
  network       = module.terraform_project.gcp_vpc_network_id
}

resource "google_service_networking_connection" "worker_pool_conn" {
  network                 = module.terraform_project.gcp_vpc_network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  peering = google_service_networking_connection.worker_pool_conn.peering
  network = module.terraform_project.gcp_vpc_name

  import_custom_routes = true
  export_custom_routes = true
}

resource "google_cloudbuild_worker_pool" "packer_pool" {
  #checkov:skip=CKV_GCP_86 External IP required for egress traffic to the Internet.
  name     = "packer-pool"
  location = local.region

  worker_config {
    disk_size_gb   = 100
    machine_type   = "e2-highcpu-8"
    no_external_ip = false
  }
  network_config {
    peered_network = module.terraform_project.gcp_vpc_network_id
  }
  depends_on = [google_service_networking_connection.worker_pool_conn]
}


