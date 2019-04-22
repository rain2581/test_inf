variable "backend_bucket" {
  description = "backend bucket name"
}

variable "vpc_name" {
  description = "VPC name"
}

variable "aws_region" {
  description = "AWS region"
}

variable "num_private_subnets" {
  description = "Number of private subnets"
}

variable "num_public_subnets" {
  description = "Number of public subnets"
}
