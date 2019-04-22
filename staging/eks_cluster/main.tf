terraform {
  backend "s3" {
    bucket = "terraform-remote-state-3storage"
    key    = "staging/eks_cluster/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
#    dynamodb_table = "terraform_statelock_staging-test-inf-000"
  }
}

data "terraform_remote_state" "vpc" {
   backend = "s3"
  config {
    bucket = "terraform-remote-state-3storage"
    key    = "staging/vpc/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

module "eks-cluster" {
  source = "../../modules/eks-cluster"
  
  aws_region = "us-east-1"
  number_of_instances = 2
  cluster_name = "test-eks-cluster"
  key_pair_name = "test-key"
  priv_subnets = ["${data.terraform_remote_state.vpc.private-subnet_id}"]
}
