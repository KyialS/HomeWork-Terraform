locals {
  instance_name       = ["first", "second"]
  availability_zone   = ["us-east-1a", "us-east-1b"]
  instance_type       = ["t2.micro", "t3.micro"]
}

resource "aws_instance" "instance" {
  count             = length(local.instance_name)
  ami               = data.aws_ami.ami.id
  instance_type     = local.instance_type[count.index]
  availability_zone = local.availability_zone[count.index]

  tags = {
    "Name" = "${local.instance_name[count.index]}"
  }
}
