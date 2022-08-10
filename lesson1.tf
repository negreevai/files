provider "aws" {}

resource "aws_instance" "my_debian" {
  count         = 1
  ami           = "ami-0a5b5c0ea66ec560d"
  instance_type = "t2.micro"

  tags = {
    Name    = "my deb srv"
    owner   = "Oleksandr Nehreiev"
    project = "Terraform lessons"
  }

}

resource "aws_instance" "my_srv2" {
  count         = 1
  ami           = "ami-0a1ee2fb28fe05df3"
  instance_type = "t2.micro"

  tags = {
    Name    = "my amz srv"
    owner   = "Oleksandr Nehreiev"
    project = "Terraform lessons"
  }
}
