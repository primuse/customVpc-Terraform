resource "aws_security_group" "private" {
  name        = "sendit_private_sg"
  description = "Security group for private instances"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr_public_subnet}"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "sendit_private_sg"
  }
}

resource "aws_security_group" "public" {
  name        = "sendit_public_sg"
  description = "Security group for public instances"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "sendit_public_sg"
  }
}

resource "aws_security_group" "database" {
  name        = "sendit_database_sg"
  description = "Security group for database instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr_private_subnet}"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "sendit_database_sg"
  }
}

resource "aws_security_group" "bastion" {
  name        = "sendit_bastion_sg"
  description = "Security group for the Bastion Host"

  # inbound traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "sendit_bastion_sg"
  }
}

resource "aws_security_group" "elb" {
  name        = "sendit_elb_sg"
  description = "Security group for the Elastic load balancer"

  # inbound traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "sendit_elb_sg"
  }
}

resource "aws_security_group" "nat" {
    name = "sendit_vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.cidr_private_subnet}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.cidr_private_subnet}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "sendit_nat_sg"
    }
}