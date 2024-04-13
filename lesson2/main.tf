resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block  
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet1_cidr_block
  availability_zone = "us-east-1a" 
         
     tags = {
      "Name" = var.name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = "us-east-1b" 

     tags = {
      "Name" = var.name
  }
}

resource "aws_instance" "instance" {
  ami             = data.aws_ami.ami.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.subnet2.id
  user_data       = var.userdata
    
     tags = {
      "Name" = var.name
  }
}