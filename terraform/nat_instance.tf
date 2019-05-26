/*
  ================= NAT Instance =================
*/
resource "aws_instance" "nat" {
  ami                         = "${data.aws_ami.sendit_nat.id}"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_pair}"
  vpc_security_group_ids      = ["${aws_security_group.nat.id}"]
  subnet_id                   = "${aws_subnet.us-east-1a-public.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name = "sendit_vpc_nat"
  }
}
