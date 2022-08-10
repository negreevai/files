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
#создаем эластик айпи, постоянный айпи
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver[0].id
}

resource "aws_instance" "my_webserver" {
  count                  = 1
  ami                    = "ami-0a1ee2fb28fe05df3" # Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags = {
    Name    = "my web srv"
    owner   = "Oleksandr Nehreiev"
    project = "Terraform lessons"
  }
  user_data = templatefile("webserver.tpl", {
    f_name = "Oleksandr"
    l_name = "Nehreiev"
    names  = ["vasya", "kolya", "petya", "john", "donald", "masha", "xyz"]
  })
  #сначала создать потом удалить старый сервер
  lifecycle {
    create_before_destroy = true
  }
  # запрещает удалять сервер после изменений
  #  lifecycle {
  # ignore_changes = ["ami","user_data"] параметрі по которым будет происходить
  #  запрет на удаление сервера
  #    prevent_destroy = true
  #  }

}



resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "Allow web inbound traffic"

  ingress {
    description = "web trafic allow 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "allow_tls"
  }
}

#вывод данных после создания сервера Ид инстанса, айпи адресс и т.д. Принято
# переносить в отдельній файл output.tf
output "webserver_instance_id" {
  value = aws_instance.my_webserver[0].id
}

output "webserver_Public_IP_address" {
  value = aws_eip.my_static_ip.public_ip
}
