variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}
