variable "aws_region" {
  description = "AWS region"
}
variable "number_of_instances" {
  description = "Number of EKS instance"
}
variable "key_pair_name" {
  description = "Key pair name for EKS"
}
variable "cluster_name" {
  description = "EKS cluster_name"
}
variable "priv_subnets" {
  description = "subnets from vpc environment"
  type = "list"
}

