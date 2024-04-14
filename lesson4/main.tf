terraform {
  backend "s3" {
    bucket = "tfstate-k"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_endpoint = "state-lock-db"
    encrypt = true
    kms_key_id = "alias/kms"
  }
}

locals {
  vpc_id = aws_vpc.vpc1.id 
  vpc_cidr ="10.0.0.0/16"
  subnet1 ="10.0.1.0/24"
  subntet2="10.0.2.0/24"
  instance_type ="t2.micro"
  name = "task4"
  user_data=null
}

resource "aws_vpc" "vpc1" {
  cidr_block = local.vpc_cidr  
     tags = {
      "Name" = "${local.name}-vpc1-kyial"
  }
}

resource "aws_vpc" "vpc2" {
  provider = aws.oregon
  cidr_block = "172.31.0.0/16"  
  enable_dns_hostnames = true
  tags = {
   "Name" = "${local.name}-vpc2-kyial"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id 
}

resource "aws_subnet" "subnet1" {
  vpc_id            = local.vpc_id
  cidr_block        = local.subnet1 
  map_public_ip_on_launch = true
   depends_on = [aws_internet_gateway.igw]
     tags = {
      "Name" = "${local.name}-public_subnet"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = local.vpc_id
  cidr_block        = local.subntet2
  depends_on = [aws_vpc.vpc1]
     tags = {
      "Name" = "${local.name}-public_subnet"
  }
}

resource "aws_subnet" "subnet_oregon" {
  provider = aws.oregon
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "172.31.1.0/24"
     tags = {
      "Name" = "${local.name}-subnet-oregon"
  }
}

resource "aws_instance" "instance1" {
  ami             = data.aws_ami.ami.id
  instance_type   = local.instance_type
  subnet_id       = aws_subnet.subnet2.id
  user_data       = local.user_data
  depends_on = [ aws_subnet.subnet2 ]

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ ami ]
  }

     tags = {
      "Name" = "${local.name}-inctance1"
  }
}

resource "aws_instance" "instance2" {
  provider = aws.oregon
  ami             = data.aws_ami.ami_oregon.id
  instance_type   = local.instance_type
  depends_on = [ aws_subnet.subnet_oregon ]

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ ami, tags["Name"] ]
  }
     tags = {
      "Name" = "${local.name}-inctance1"
  }
}

resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "allow HTTP, HTTPS, SSH"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
   "Name" = "public_sg"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc1.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags={
    "Name"="public_rt"
    "Name"="${local.name}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id    = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    "Name" ="private_rt"
    "Name" = "${local.name}"
  } 
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id       = aws_subnet.subnet1.id
  tags = {
   "Name" = "nat_subnet2"
   "Name" = "${local.name}"
  }
}

resource "aws_eip" "eip" {
   domain = "vpc"
  tags = {
   "Name" = "eip_for_nat"
   "Name" = "${local.name}"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_route_table.id  
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.private_route_table.id  
}
