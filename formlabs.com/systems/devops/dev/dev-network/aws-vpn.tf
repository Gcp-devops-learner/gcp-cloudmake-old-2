resource "null_resource" "ram" {
  provisioner "local-exec" {
    command = "aws ram enable-sharing-with-aws-organization"
  }

  triggers = {
    account_id = local.aws_account_id
  }
}

module "vpn_aws_tgw_dev_us_east_1" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.8.1"

  name            = "vpn-tgw-dev-us-east-1"
  amazon_side_asn = local.aws_asn

  enable_auto_accept_shared_attachments = true
  ram_allow_external_principals         = true

  vpc_attachments = {
    vpc = {
      vpc_id      = local.aws_dev_vpc_id
      subnet_ids  = data.aws_subnets.dev_subnets.ids
      dns_support = true

      tgw_routes = [
        {
          destination_cidr_block = "10.235.0.0/16"
        },
      ]
    }
  }
}

module "vpn_us_east_1" {
  source  = "spotify/aws-hybrid-cloud-vpn/google"
  version = "~>1.0.1"

  transit_gateway_id = module.vpn_aws_tgw_dev_us_east_1.ec2_transit_gateway_id
  google_network     = module.dev_network.gcp_vpc_network_id
  amazon_side_asn    = local.aws_asn
  google_side_asn    = local.gcp_asn
}
