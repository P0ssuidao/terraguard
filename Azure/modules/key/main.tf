resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_ssh_public_key" "generated_key" {
  name   = var.key_name
  resource_group_name = var.rg_name
  location            = var.key_location
  public_key          = tls_private_key.ssh_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > /tmp/'${var.key_name}'.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 /tmp/'${var.key_name}'.pem"
  }

}