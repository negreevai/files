data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region_name" {
  value = data.aws_region.current.name
}

output "data_aws_region_description" {
  value = data.aws_region.current.description
}

output "deb_web_instance_id" {
  value = aws_instance.debian_srv_web.id
}

output "deb_app_instance_id" {
  value = aws_instance.debian_srv_app.id
}
output "deb_db_instance_id" {
  value = aws_instance.debian_srv_db.id
}
#output "webserver_Public_IP_address" {
#  value = aws_eip.my_static_ip.public_ip
#}
