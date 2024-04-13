output "instance_ids" {
  description = "ID  EC2"
  value       = [aws_instance.instance1.id , aws_instance.instance2]
}

output "subnet_ids" {
  description = "IDs Subnets"
  value       = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

output "vpc_ids" {
  description = "ID VPC1"
  value       = [aws_vpc.vpc1.id , aws_vpc.vpc2.id]
}

output "vpc_cidr_block" {
  description = "CIDR_BLOCK VPC"
  value       = aws_vpc.vpc1.cidr_block
}