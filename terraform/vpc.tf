# Creates a virtual private network
resource "aws_vpc" "main" {
  cidr_block       = "${var.cidr_vpc}"
  enable_dns_hostnames = true

  tags = {
    Name = "sendit-vpc"
  }
}

# Creates an internet gateway
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.main.id}"
}


/*
  ================= Public Subnet ==================
*/

# Creates the public subnet
resource "aws_subnet" "us-east-2a-public" {
    vpc_id = "${aws_vpc.main.id}"

    cidr_block = "${var.cidr_public_subnet}"
    availability_zone = "us-east-2a"

    tags {
        Name = "Sendit_Public_Subnet"
    }
}

# Creates the public subnet route table
resource "aws_route_table" "us-east-2a-public" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "public_subnet_rt"
    }
}

# Creates the public subnet route table association
resource "aws_route_table_association" "us-east-2a-public" {
    subnet_id = "${aws_subnet.us-east-2a-public.id}"
    route_table_id = "${aws_route_table.us-east-2a-public.id}"
}

/*
  ================= Private Subnet ================= 
*/

# Creates the private subnet
resource "aws_subnet" "us-east-2a-private" {
    vpc_id = "${aws_vpc.main.id}"

    cidr_block = "${var.cidr_private_subnet}"
    availability_zone = "us-east-2a"

    tags {
        Name = "Sendit_Private_Subnet"
    }
}

# Creates the private subnet route table
resource "aws_route_table" "us-east-2a-private" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "private_subnet_rt" 
    }
}

# Creates the private subnet route table association
resource "aws_route_table_association" "us-east-2a-private" {
    subnet_id = "${aws_subnet.us-east-2a-private.id}"
    route_table_id = "${aws_route_table.us-east-2a-private.id}"
}

