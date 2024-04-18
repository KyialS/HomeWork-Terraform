locals {
  name="ec2-k"
}
resource "aws_instance" "instance" {
  count           = length(data.terraform_remote_state.networking.outputs.subnet_ids)
  ami             = data.aws_ami.ami.id
  instance_type   = "t3.micro"
  subnet_id       = data.terraform_remote_state.networking.outputs.subnet_ids[count.index]
  security_groups = [values(aws_security_group.sg)[count.index].id]

  tags = {
    "Name" = local.name
  }
}

  

resource "aws_security_group" "sg" {
  vpc_id = data.terraform_remote_state.networking.outputs.vpc

  for_each = {
    "sg1" = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    "sg2" = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    "sg3" = {
      from_port   = 22
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  name_prefix = each.key

  ingress {
    from_port   = each.value.from_port
    to_port     = each.value.to_port
    protocol    = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
  }
}
