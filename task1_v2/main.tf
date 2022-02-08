provider "aws" {
    access_key = var.acc_key
    secret_key = var.sec_key
    region = "eu-central-1"
}

data "aws_vpcs" "selected" {}

output "data_aws_vpcs" {
  value = data.aws_vpcs.selected.ids
}

data "aws_subnets" "selected" {}

output "data_subnets" {
  value = data.aws_subnets.selected.ids
}

data "aws_security_groups" "selected" {
  filter {
    name   = "vpc-id"
    values = ["${var.vpc_id}"]
  }
}

output "data_security_groups" {
  value = data.aws_security_groups.selected.ids
}