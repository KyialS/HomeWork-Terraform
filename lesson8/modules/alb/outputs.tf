output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_listener_ports" {
  value = var.alb_listener_ports
}

# output "availability_zones" {
#   value = aws_vpc.vpc.availability_zones
# }
