output "public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}

output "private_key" {
  value = tls_private_key.ssh_key.private_key_openssh
}