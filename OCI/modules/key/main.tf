resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "null_resource" "ssh_key" {
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > /tmp/'${var.key_name}'.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 /tmp/'${var.key_name}'.pem"
  }
}