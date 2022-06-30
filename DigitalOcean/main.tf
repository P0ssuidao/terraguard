terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = "TerraGuard"
  public_key = tls_private_key.ssh_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > /tmp/'${var.key_name}'.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 /tmp/'${var.key_name}'.pem"
  }
}

resource "digitalocean_droplet" "terraguard" {
  image    = "ubuntu-20-04-x64"
  name     = "terraguard"
  region   = var.do-region
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.ssh_key.fingerprint]
  depends_on = [
    digitalocean_ssh_key.ssh_key
  ]
}


resource "digitalocean_firewall" "terraguard_fw" {
  name        = "terraguard-fw"
  droplet_ids = [digitalocean_droplet.terraguard.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "41194"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  depends_on = [
    digitalocean_droplet.terraguard
  ]
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      wireguard = digitalocean_droplet.terraguard.ipv4_address
      key       = var.key_name
      mobile    = var.mobile ? true : "False"
    }
  )
  filename = "../ansible/hosts.cfg"
  depends_on = [
    digitalocean_droplet.terraguard
  ]
}

resource "time_sleep" "wait_60_seconds" {
  depends_on      = [digitalocean_droplet.terraguard]
  create_duration = "60s"
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
  value = digitalocean_droplet.terraguard.ipv4_address
}
