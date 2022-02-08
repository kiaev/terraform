provider "aws" {
    access_key = var.acc_key
    secret_key = var.sec_key
    region = "eu-central-1"
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}
data "aws_subnet" "selected" {
   id = var.subnet_id
}
data "aws_security_group" "selected" {
  id = var.security_group_id
}

output "data_vpc" {
  value = data.aws_vpc.selected.arn
}
output "data_subnet" {
  value = data.aws_subnet.selected.arn
}
output "data_sec_gps" {
  value = data.aws_security_group.selected.arn
}

