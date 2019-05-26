data "aws_ami" "sendit_db" {
  most_recent = true

  filter {
    name   = "name"
    values = ["SendIt-Database"] # Filter ami with the value 'SendIt-Database' and gets the latest one"
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

data "aws_ami" "sendit_api" {
  most_recent = true

  filter {
    name   = "name"
    values = ["SendIt-Api"] # Filter ami with the value 'SendIt-Api' and gets the latest one"
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

data "aws_ami" "sendit_frontend" {
  most_recent = true

  filter {
    name   = "name"
    values = ["SendIt-Public"] # Filter ami with the value 'SendIt-Public' and gets the latest one"
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

data "aws_ami" "sendit_nat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["SendIt-NAT"] # Filter ami with the value 'SendIt-NAT' and gets the latest one"
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}
