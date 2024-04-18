output "vpc" {
    value=aws_vpc.vpc.id
  
}

output "subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

