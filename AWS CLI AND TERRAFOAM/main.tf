provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "lab2_bucket" {
  bucket = "terraform-lab2-bucket-saimsec-12345"

  tags = {
  Name        = "Lab2Bucket"
  Environment = "Dev"
  Owner       = "Saim"
    }
}
