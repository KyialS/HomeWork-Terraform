variable "vpc_cidr" {
default = "10.0.0.0/16"
}
variable "name" {
 default = "kyial"

}
variable "public_cidrs" {
default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_cidrs" {
default = []
}

# variable "availability_zones" {
#   type    = list(string)
#   default = ["us-east-1a", "us-east-1b", "us-east-1c"] # Замените значениями своих зон доступности
# }

