provider "aws" {}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


data "aws_vpc" "Debian-server-db_vpc" {
  tags = {
    Name = "Debian-server-db"
  }
}

output "Debian-server-db_vpc_id" {
  value = data.aws_vpc.Debian-server-db_vpc.id
}

output "Debian-server-db_vpc_cidr" {
  value = data.aws_vpc.Debian-server-db_vpc.cidr_block
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region_name" {
  value = data.aws_region.current.name
}

output "data_aws_region_description" {
  value = data.aws_region.current.description
}
