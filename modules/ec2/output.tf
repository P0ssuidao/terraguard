output "ec2-public" {
  value = aws_instance.vpn.public_ip
}