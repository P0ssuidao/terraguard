provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}
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

resource "google_compute_firewall" "terraguard" {
  name    = "terraguard-firewall"
  network = var.vpc

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "udp"
    ports    = ["41194"]
  }
  target_tags = ["terraguard"]
}


resource "google_compute_instance" "terraguard" {
  name         = "terraguard"
  machine_type = "f1-micro"
  can_ip_forward = true
  tags = ["terraguard"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
    }
  }

  network_interface {
    network = var.vpc
    access_config {
      // Ephemeral IP
    }
  }  
  metadata = {
    ssh-keys = "terraguard:${tls_private_key.ssh_key.public_key_openssh}"
  }
}


resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      wireguard = google_compute_instance.terraguard.network_interface.0.access_config.0.nat_ip
      key       = var.key_name
    }
  )
  filename = "../ansible/hosts.cfg"
  depends_on = [
    google_compute_instance.terraguard
  ]
}

resource "time_sleep" "wait_60_seconds" {
  depends_on      = [google_compute_instance.terraguard]
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

output "HELP" {
  value = "To start VPN run: sudo systemctl start wg-quick@wg0"
}

output "ExitIP" {
  value = google_compute_instance.terraguard.network_interface.0.access_config.0.nat_ip
}
