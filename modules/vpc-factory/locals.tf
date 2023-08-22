locals {
  egress_internet_routes = [
    {
      name              = "egress-internet"
      description       = "Route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    },
  ]

  routes = var.enable_internet_gateway_routes ? concat(local.egress_internet_routes, var.routes) : var.routes
}
