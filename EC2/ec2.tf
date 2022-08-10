#-------------------------------
# terraform
#
# Debian server
#made Oleksandr Nehreiev
#--------------------------------


provider "aws" {
  region = "eu-central-1"

}

resource "aws_instance" "debian_srv_web" {
  ami                    = "ami-0a5b5c0ea66ec560d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.debian_srv.id]

  tags = {
    Name = "Debian_server_web"
  }
  depends_on = [aws_instance.debian_srv_app, aws_instance.debian_srv_db]
}

resource "aws_instance" "debian_srv_app" {
  ami                    = "ami-0a5b5c0ea66ec560d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.debian_srv.id]

  tags = {
    Name = "Debian_server_app"
  }
  #Приоритет за каким сервером поднимать этот
  depends_on = [aws_instance.debian_srv_db]

}
resource "aws_instance" "debian_srv_db" {
  ami                    = "ami-0a5b5c0ea66ec560d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.debian_srv.id]

  tags = {
    Name = "Debian_server_db"
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
