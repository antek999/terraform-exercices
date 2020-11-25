output "ip_addresses" {
  value = {
    "web-1-ip" : aws_instance.web-1.public_ip,
    "web-2-ip" : aws_instance.web-2.public_ip,
    "app-1-ip" : aws_instance.app-1.private_ip,
    "app-2-ip" : aws_instance.app-2.private_ip,
    "db-1-endpoint" : aws_db_instance.main-db.endpoint
  }
}

output "nat-gw-ip-addresses" {
  value = aws_nat_gateway.nat-gw.*.public_ip
}