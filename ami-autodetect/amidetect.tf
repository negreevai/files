#--------------------------
# terraform
#Find latest AMIs ID :
# debian
#amazon linux
#Windows
#---------------------------


provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "latest_debian" {
  owners      = ["136693071363"]
  most_recent = true
  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }
}

resource "aws_instance" "debian_srv_web" {
  ami                    = data.aws_ami.latest_debian.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.debian_srv.id]

  tags = {
    Name = "Debian_server_web"
  }
}

resource "aws_security_group" "debian_srv" {
  name = "my security group"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ports"
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windows_server2016" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
}

output "latest_debian_ami_id" {
  value = data.aws_ami.latest_debian.id
}

output "latest_debian_ami_name" {
  value = data.aws_ami.latest_debian.name
}


output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "latest_amazon_linux_ami_name" {
  value = data.aws_ami.latest_amazon_linux.name
}

output "latest_windows_server2016_ami_id" {
  value = data.aws_ami.latest_windows_server2016.id
}

output "latest_windows_server2016_name" {
  value = data.aws_ami.latest_windows_server2016.name
}
