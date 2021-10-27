data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "instance-public" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  monitoring = true
  subnet_id   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  key_name= "aws-key"
  vpc_security_group_ids = [aws_security_group.main.id]
  connection {
      private_key = file("~/run/temp/aws-key")
      timeout     = "4m"
   }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "instance-public"
  }
}

resource "aws_instance" "instance-private" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  monitoring = true
  subnet_id   = aws_subnet.private_subnet.id
  key_name= "aws-key"
  vpc_security_group_ids = [aws_security_group.main.id]
  connection {
      private_key = file("~/run/temp/aws-key")
      timeout     = "4m"
   }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "instance-private"
  }
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.vpc-task.id
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "aws-key" {
  key_name   = "aws-key"
  public_key = var.pk
}