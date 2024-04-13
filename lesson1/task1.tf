resource "aws_instance" "first_instance" {
  associate_public_ip_address = true
  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t2.micro"

   tags = {
    Name = "first"
  }                
}

resource "aws_instance" "second_instance" {
  associate_public_ip_address = false
  ami                         = "ami-051f8a213df8bc089"
  instance_type               = "t3.micro"
  availability_zone           = "us-east-1a"

  tags = {
    Name = "Second_"
  }
}

resource "aws_instance" "third_instance" {
    associate_public_ip_address = false
    ami                         = "ami-080e1f13689e07408"
    instance_type               = "t2.micro"
    monitoring                  = true

   tags = {
    Name = "Third_"
  }
}
#endbdjbds
