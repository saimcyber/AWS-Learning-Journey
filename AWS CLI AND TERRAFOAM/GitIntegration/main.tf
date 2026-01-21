provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "git_lab_bucket" {
  bucket = "terraform-git-lab-saimcyber"

tags = {
  Name        = "GitLabBucket"
  Environment = "Dev"
  Owner       = "Saim"
}

}
