variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "aws_region" {
  description = "EC2 Region for the VPC"
  default = "us-east-2"
}

variable "key_pair" {}

variable "cidr_vpc" {
  description = "cdir for vpc"
  default     = "172.16.0.0/16"
}

variable "cidr_public_subnet" {
  description = "cidr for public subnet"
  default     = "172.16.1.0/24"
}

variable "cidr_private_subnet" {
  description = "cidr for private subnet"
  default     = "172.16.2.0/24"
}
