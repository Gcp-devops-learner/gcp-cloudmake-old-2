module "dev_network" {
  source = "../../../../../modules/vpc-factory"

  project_id      = local.project_id
  network_name    = "dev-network"
  shared_vpc_host = true
  subnets = [
    {
      subnet_name   = "dev-shared-network"
      subnet_ip     = "10.235.0.0/24"
      subnet_region = "us-east1"
    },
  ]
  secondary_ranges = {
    dev-shared-network = [
      {
        ip_cidr_range = "10.235.1.0/24"
        range_name    = "pods"
      },
      {
        ip_cidr_range = "10.235.2.0/24"
        range_name    = "services"
      },
    ]
  }
}
