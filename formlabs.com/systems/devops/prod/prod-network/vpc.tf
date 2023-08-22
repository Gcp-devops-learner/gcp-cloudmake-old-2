module "prod_network" {
  source = "../../../../../modules/vpc-factory"

  project_id                     = local.project_id
  network_name                   = "prod-network"
  shared_vpc_host                = true
  enable_internet_gateway_routes = false
  description                    = "Main Production Network GCP"
  mtu                            = 1460
  subnets = [
    {
      subnet_name   = "prod-shared-network"
      subnet_ip     = "10.236.0.0/24"
      subnet_region = "us-east1"
      description   = "prod-shared-network"
    },
  ]
  secondary_ranges = {
    prod-shared-network = [
      {
        ip_cidr_range = "10.236.1.0/24"
        range_name    = "pods"
      },
      {
        ip_cidr_range = "10.236.2.0/24"
        range_name    = "services"
      },
    ]
  }
}
