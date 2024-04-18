provider "aws" {
    region = "us-east-1"
}
locals {
  name = "vpc-kyial"
  vpc = aws_vpc.vpc.id

  public_subnet_names = ["public-subnet-1", "public-subnet-2", "public-subnet-3"]
  private_subnet_names = ["private-subnet-1", "private-subnet-2", "private-subnet-3"]
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "${local.name}-name"
  }
}

resource "aws_subnet" "public_subnet" {
  count    = length(local.public_subnet_names)
  vpc_id   = local.vpc
  cidr_block = tolist(toset(["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]))[count.index]

  tags = {
    "Name" = local.public_subnet_names[count.index]
  }
}

resource "aws_subnet" "private_subnet" {
  count    = length(local.private_subnet_names)
  vpc_id   = local.vpc
  cidr_block = tolist(toset(["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]))[count.index]

  tags = {
    "Name" = local.private_subnet_names[count.index]
  }
}
