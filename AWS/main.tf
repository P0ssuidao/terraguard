provider "aws" {
  region = var.region
}

module "sg" {
  source = "./modules/sg"
}

module "key" {
  source   = "./modules/key"
  key_name = var.key_name
}

module "ec2" {
  source          = "./modules/ec2"
  key_name        = module.key.wirevpn-key
  security_groups = module.sg.sg-out-terraguard-sg-name
  depends_on = [
    module.sg,
    module.key
  ]
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      wireguard = module.ec2.ec2-public
      key       = var.key_name
      mobile    = var.mobile ? true : "False"
    }
  )
  filename = "../ansible/hosts.cfg"
  depends_on = [
    module.ec2,
    module.key,
    module.sg
  ]
}

resource "time_sleep" "wait_60_seconds" {
  depends_on      = [module.ec2]
  create_duration = "60s"
}

resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -K -i ../ansible/hosts.cfg ../ansible/main.yml"
  }
  depends_on = [
    local_file.hosts_cfg,
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "mobile_qr" {
  count              = var.mobile ? 1 : 0
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
  value = module.ec2.ec2-public
}
