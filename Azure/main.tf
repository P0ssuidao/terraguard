provider "azurerm" {
  features {}
}

provider "random" {
  # Configuration options
}

resource "random_id" "dns" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-terraguard"
  location = var.region
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["172.16.0.0/16"]
  subnet_prefixes     = ["172.16.0.0/24"]
  subnet_names        = ["terraguard-subnet"]

  nsg_ids = {
    terraguard-subnet = module.network-security-group.network_security_group_id
  }


  depends_on = [azurerm_resource_group.rg]
}

module "network-security-group" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  security_group_name = "terraguard-nsg"

  custom_rules = [
    {
      name                       = "ssh"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      destination_address_prefix = "*"
      source_address_prefix      = "*"
      description                = "description-myssh"
    },
    {
      name                       = "wireguard"
      priority                   = 210
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "udp"
      source_port_range          = "*"
      destination_port_range     = "41194"
      destination_address_prefix = "*"
      source_address_prefix      = "*"
      description                = "description-myssh"
    }
  ]

  depends_on = [azurerm_resource_group.rg]
}

module "linuxservers" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["terraguard-${random_id.dns.hex}"]
  vnet_subnet_id      = module.vnet.vnet_subnets[0]
  ssh_key_values      = [module.key.wirevpn-key]

  depends_on = [azurerm_resource_group.rg, module.key.wirevpn-key]
}

module "key" {
  source       = "./modules/key"
  key_name     = var.key_name
  rg_name      = azurerm_resource_group.rg.name
  key_location = azurerm_resource_group.rg.location
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      wireguard = module.linuxservers.public_ip_dns_name[0]
      key       = module.key.key_name
      mobile    = var.mobile ? true : "False"
    }
  )
  filename = "../ansible/hosts.cfg"
  depends_on = [
    module.linuxservers.public_ip_dns_name
  ]
}

resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/hosts.cfg ../ansible/main.yml"
  }
  depends_on = [
    local_file.hosts_cfg,
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "mobile_qr" {
  count = var.mobile ? 1 : 0
  provisioner "local-exec" {
    command = "qrencode -t ansiutf8 < /tmp/terraguard-mobile.conf"
  }
  depends_on = [
    null_resource.ansible
  ]
}

output "HELP" {
  value = "To start VPN run: sudo systemctl start wg-quick@wg0"
}

output "ExitIP" {
  value      = module.linuxservers.public_ip_address[0]
  depends_on = [module.linuxservers]
}


resource "time_sleep" "wait_60_seconds" {
  depends_on      = [module.linuxservers]
  create_duration = "60s"
}


output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_dns_name
}