provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "private-subnet" {
  count      = "${var.num_private_subnets}"
  vpc_id     = "${aws_vpc.test-vpc.id}"
  cidr_block = "10.0.${count.index + 1}.0/24"

  tags {
    Name = "private-subnet-${count.index + 1}"
  }
}

#Define public subnet
resource "aws_subnet" "public-subnet" {
  count      = "${var.num_public_subnets}"
  vpc_id     = "${aws_vpc.test-vpc.id}"
  cidr_block = "10.0.${count.index + 129}.0/24"

  tags {
    Name = "public-subnet-${count.index + 1}"
  }
}

#Define internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.test-vpc.id}"

  tags {
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "default_route_public_subnet" {
  vpc_id = "${aws_vpc.test-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "default-route-public-subnet"
  }
}

#Assign the route table to the public Subnet
resource "aws_route_table_association" "default_route_public_subnet" {
  #  count = "${length(aws_subnet.public-subnet.*.id)}"
  count          = "${var.num_public_subnets}"
  subnet_id      = "${element(aws_subnet.public-subnet.*.id , count.index)}"
  route_table_id = "${aws_route_table.default_route_public_subnet.id}"
  depends_on     = ["aws_subnet.public-subnet"]
}
