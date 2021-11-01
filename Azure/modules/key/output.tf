output "wirevpn-key" {
  value = azurerm_ssh_public_key.generated_key.public_key
}

output "key_name" {
  value = azurerm_ssh_public_key.generated_key.name
}