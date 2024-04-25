locals {
  ingress_ports      = [22, 80, 443]
  alb_listener_ports = [80, 443, 8080]
}

module "vpc" {
  source       = "../../modules/vpc"
  public_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "asg" {
  source = "../../modules/asg"
  public_subnets = [module.vpc.public_subnets_ids["10.0.1.0/24"], module.vpc.public_subnets_ids["10.0.2.0/24"]]
  sg             = [aws_security_group.sg.id]
}

resource "aws_security_group" "sg" {
  vpc_id = module.vpc.vpc_id
  dynamic "ingress" {
    for_each = toset(local.ingress_ports)
    content {
      to_port     = ingress.value
      from_port   = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "alb" {
  source             = "../../modules/alb"
  alb_subnet_ids     = [module.vpc.public_subnets_ids["10.0.1.0/24"], module.vpc.public_subnets_ids["10.0.2.0/24"]]
  alb_name           = "alb-task8"
  alb_listener_ports = local.alb_listener_ports
  vpc                = module.vpc.vpc_id
}




