data "aws_subnets" "dev_subnets" {
  filter {
    name   = "vpc-id"
    values = [local.aws_dev_vpc_id]
  }
}
