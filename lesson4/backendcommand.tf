# terraform {
#   backend "s3" {
#     bucket = "tfstate-k" 
#     key = "dev/terraform.tfstate"
#     region = "us-east-1"
#     dynamodb_endpoint = "state-lock-db"
#     encrypt = true
#     kms_key_id = "alias/kms"
#   }
# }

# resource "aws_dynamodb_table" "db_state_lock" {
#   name = "state-lock-db"
#   hash_key = "LockID"
#   read_capacity = 20
#   write_capacity = 20

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# resource "aws_s3_bucket" "s3" {
#   bucket = "tfstate-k"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }
# resource "aws_s3_bucket_versioning" "versioning" {
#   bucket = aws_s3_bucket.s3.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }