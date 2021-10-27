output "ip_pub" {
  value = aws_eip.ip_priv.public_ip
}