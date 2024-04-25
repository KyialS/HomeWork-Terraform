variable "name_prefix" {
  default = "kyial-task8"  
}
variable "instance_type" {
    default = "t2.micro"
}
variable "desired_capacity" {
    default = 2
}
variable "max_size" {
    default = 3
}
variable "min_size" {
    default = 1
}
variable "public_subnets"{}
variable "sg" {
  
}

