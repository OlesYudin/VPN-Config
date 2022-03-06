# Output public IP of EC2 instance
output "vpn-server_ip" {
  value = aws_instance.vpn.public_ip
}
