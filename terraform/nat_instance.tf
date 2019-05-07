/*
  ================= NAT Instance =================
*/
resource "aws_instance" "nat" {
  ami = "ami-0f9c61b5a562a16af" # this is a special ami preconfigured to do NAT
  availability_zone = "us-east-2a"
  instance_type = "t2.micro"
  key_name = "${var.key_pair}"
  vpc_security_group_ids = ["${aws_security_group.nat.id}"]
  subnet_id = "${aws_subnet.us-east-2a-public.id}"
  associate_public_ip_address = true
  source_dest_check = false

  tags {
    Name = "sendit_vpc_nat"
  }
}
