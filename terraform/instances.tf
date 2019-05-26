# Create the ec2 instance for the backend
provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY_ID}"
  secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "backend" {
  ami                    = "${data.aws_ami.sendit_api.id}"
  availability_zone      = "us-east-1a"
  instance_type          = "t2.micro"
  key_name               = "${var.key_pair}"
  vpc_security_group_ids = ["${aws_security_group.private.id}"]
  subnet_id              = "${aws_subnet.us-east-1a-private.id}"

  tags {
    Name = "sendit_backend"
  }
}

# Create the ec2 instance for the frontend
resource "aws_instance" "frontend" {
  ami                         = "${data.aws_ami.sendit_frontend.id}"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_pair}"
  vpc_security_group_ids      = ["${aws_security_group.public.id}"]
  subnet_id                   = "${aws_subnet.us-east-1a-public.id}"
  associate_public_ip_address = true

  tags {
    Name = "sendit_frontend"
  }
}

# Create the ec2 instance for the database
resource "aws_instance" "database" {
  ami                    = "${data.aws_ami.sendit_db.id}"
  availability_zone      = "us-east-1a"
  instance_type          = "t2.micro"
  key_name               = "${var.key_pair}"
  vpc_security_group_ids = ["${aws_security_group.database.id}"]
  subnet_id              = "${aws_subnet.us-east-1a-private.id}"

  tags {
    Name = "sendit_database"
  }
}
