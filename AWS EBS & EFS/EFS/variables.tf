variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID where EFS will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EFS mount targets"
  type        = list(string)
}

variable "allowed_cidr" {
  description = "CIDR allowed to access EFS (NFS)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
