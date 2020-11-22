output "ip_addresses" {
  value = {
      "web-1-ip ": aws_instance.web-1.public_ip, 
      "web-2-ip": aws_instance.web-2.public_ip
      }
    
 # name = "ip addresses"
}
