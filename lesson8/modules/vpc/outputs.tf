output "public_subnets_ids" {
  value = { for key, subnet in aws_subnet.public_subnets : key => subnet.id }
}


output "vpc_id" {
    value=aws_vpc.vpc.id
  
}

# output "availability_zones" {
#   value = aws_vpc.vpc.availability_zones
# }


