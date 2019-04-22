output "public_cidr" {
  description = "list cidr block for public subnet"
  value       = ["${aws_subnet.public-subnet.*.cidr_block}"]
}

output "public-subnet_id" {
  description = "List of public subnet id"
  value       = ["${aws_subnet.public-subnet.*.id}"]
}

output "private-subnet_id" {
  description = "List of private subnet id"
  value       = ["${aws_subnet.private-subnet.*.id}"]
}


output "vpc_cidr_block" {
  description = "VPC cidr block"
  value       = "${aws_vpc.test-vpc.cidr_block}"
}

output "count_public_subnets" {
  description = "Number of public subnets"
  value       = "${length(aws_subnet.public-subnet.*.id)}"
}
