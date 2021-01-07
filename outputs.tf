output "ip_addresses_pub" {
  value = join(",", aws_instance.ec2-web.*.public_ip)
}

output "ip_addresses_priv" {
  value = join(",", aws_instance.ec2-app.*.private_ip)
}

output "nat-gw-ip-addresses" {
  value = aws_nat_gateway.nat-gw.*.public_ip
}

output "db_endpoint" {
  value = {
    "db-1-endpoint" : aws_db_instance.main-db.*.endpoint
  }
}
