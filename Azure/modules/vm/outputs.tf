output "vm_ids" {
  description = "Virtual machine ids created."
  value       = concat(azurerm_virtual_machine.vm-windows.*.id, azurerm_virtual_machine.vm-linux.*.id)
}

output "network_interface_ids" {
  description = "ids of the vm nics provisoned."
  value       = azurerm_network_interface.vm.*.id
}

output "network_interface_private_ip" {
  description = "private ip addresses of the vm nics"
  value       = azurerm_network_interface.vm.*.private_ip_address
}

output "public_ip_id" {
  description = "id of the public ip address provisoned."
  value       = azurerm_public_ip.vm.*.id
}

output "public_ip_address" {
  description = "The actual ip address allocated for the resource."
  value       = data.azurerm_public_ip.vm.*.ip_address
}

output "public_ip_dns_name" {
  description = "fqdn to connect to the first vm provisioned."
  value       = azurerm_public_ip.vm.*.fqdn
}

output "availability_set_id" {
  description = "id of the availability set where the vms are provisioned."
  value       = azurerm_availability_set.vm.id
}

output "vm_zones" {
  description = "map with key `Virtual Machine Id`, value `list of the Availability Zone` which the Virtual Machine should be allocated in."
  value       = zipmap(concat(azurerm_virtual_machine.vm-windows.*.id, azurerm_virtual_machine.vm-linux.*.id), concat(azurerm_virtual_machine.vm-windows.*.zones, azurerm_virtual_machine.vm-linux.*.zones))
}

output "vm_identity" {
  description = "map with key `Virtual Machine Id`, value `list of identity` created for the Virtual Machine."
  value       = zipmap(concat(azurerm_virtual_machine.vm-windows.*.id, azurerm_virtual_machine.vm-linux.*.id), concat(azurerm_virtual_machine.vm-windows.*.identity, azurerm_virtual_machine.vm-linux.*.identity))
}
