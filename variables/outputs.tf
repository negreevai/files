output "amazon_srv_ip" {
  value = aws_eip.my_static_ip.public_ip
}

output "amazon_srv_id" {
  value = "aws_instance.amazon_srv.id"
}

output "my_sg_id" {
  value = aws_security_group.amazon_srv.id
}
