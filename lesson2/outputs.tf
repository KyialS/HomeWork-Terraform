output "instance_id" {
  description = "ID  EC2"
  value       = aws_instance.instance.id
}

output "subnet_ids" {
  description = "IDs Subnets"
  value       = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

output "vpc_id" {
  description = "ID VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR_BLOCK VPC"
  value       = aws_vpc.vpc.cidr_block
}