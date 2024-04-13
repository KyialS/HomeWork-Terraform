variable "vpc_cidr_block" {
  description = "CIDR_BLOCK for VPC"
  type        = string
}

variable "subnet1_cidr_block" {
  description = "CIDR_BLOCK for Subnet 1"
  type        = string
}

variable "subnet2_cidr_block" {
  description = "CIDR_Block for Subnet 2"
  type        = string
}

variable "instance_type" {
    type    = string
    default = "t3.micro"
}

variable "userdata" {
    default = null
}

variable "name" {
  type        = string
  default     = "task2"
}