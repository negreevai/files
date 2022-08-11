#-----------------------------------
# variable
# terraform
#------------------------------------

provider "aws" {
  region = var.region
  #"eu-central-1"
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "amazon_srv" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.amazon_srv.id]
  monitoring             = var.enable_detailed_monitoring

  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Amazon Linux SRV" })
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.amazon_srv.id
  //  tags     = var.common_tags
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server IP" })
  /*
  tags = {
    Name    = "Server IP"
    Owner   = "Oleksandr Nehreiev"
    Project = "EDU"
    Region  = var.region
  }
*/
}

resource "aws_security_group" "amazon_srv" {
  name = "my security group"

  dynamic "ingress" {
    for_each = var.allow_ports
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
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} allow_ports" })

}
