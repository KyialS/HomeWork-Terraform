terraform {
  backend "s3" {
    bucket = "s3-for-task7-kyial" 
    key = "networking/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_endpoint = "state-lock-db"
    # encrypt = true
    # kms_key_id = "alias/kms"
  }
}