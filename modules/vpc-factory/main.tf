module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0"

  project_id                             = var.project_id
  network_name                           = var.network_name
  description                            = var.description
  mtu                                    = var.mtu
  subnets                                = var.subnets
  secondary_ranges                       = var.secondary_ranges
  firewall_rules                         = var.firewall_rules
  shared_vpc_host                        = var.shared_vpc_host
  routing_mode                           = "REGIONAL"
  auto_create_subnetworks                = false
  delete_default_internet_gateway_routes = true
  routes                                 = local.routes
}
