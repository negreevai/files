#------------------------------------------
#My Terraform lessons
#
# Build webserver
#
#Made by Oleksandr Nehreiev
#------------------------------------------

provider "aws" {
  region = "eu-central-1"
}



resource "aws_security_group" "my_webserver" {
  name        = "Dynamic Security Group"
  description = "Allow web inbound traffic"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "1541", "9092"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  ingress {
    description = "web trafic allow 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web_traffic"
  }
}
