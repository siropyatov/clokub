provider "aws" {
  region = "us-east-1"

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "netology-vpc"
  cidr = "172.31.0.0/16"
  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

 data "aws_ami" "amazon-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}