terraform {
  backend "s3" {
    bucket = "terraform-remote-state-3storage"
    key    = "staging/vpc/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
#    dynamodb_table = "terraform_statelock_staging-test-inf-000"
  }
}

module "staging_vpc" {
  source = "../../modules/test-vpc"
 
  backend_bucket = "test_backend_bucket_1234"
  vpc_name = "test-vpc"
  aws_region = "us-east-1"
  num_private_subnets = 2
  num_public_subnets = 2
}

output "public_cidr" {
  description = "list cidr block for public subnet"
  value = "${module.staging_vpc.public_cidr}"
}

output "public-subnet_id" {
  description = "List of public subnet id"
  value = "${module.staging_vpc.public-subnet_id}"
}

output "private-subnet_id" {
  description = "List of private subnet id"
  value = "${module.staging_vpc.private-subnet_id}"
}


output "vpc_cidr_block" {
  description = "VPC cidr block"
  value = "${module.staging_vpc.vpc_cidr_block}"
}
output "count_public_subnets" {
 description = "Number or public subnets"
 value = "${module.staging_vpc.count_public_subnets}"
}

