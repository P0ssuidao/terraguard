module "compartment" {
  source = "./modules/compartment"
  compartment_name = var.compartment_name
}

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.6.0"

  compartment_id = module.compartment.compartment_id
  region         = var.region

  internet_gateway_route_rules = null
  local_peering_gateways       = null
  nat_gateway_route_rules      = null

  vcn_name      = var.vcn_name
  vcn_dns_label = var.vcn_dns_label
  vcn_cidrs     = ["10.0.0.0/16"]

  create_internet_gateway = true
}

module "network" {
  source = "./modules/network"

  vcn_id         = module.vcn.vcn_id
  ig_route_id    = module.vcn.ig_route_id
  compartment_id = module.compartment.compartment_id
}

module "key" {
  source   = "./modules/key"
  key_name = var.key_name
}

module "instance" {
  source = "./modules/instance"

  compartment_id = module.compartment.compartment_id
  vcn_subnet_id  = module.network.public_subnet_id
  public_key     = module.key.public_key
  private_key    = module.key.private_key
  shape          = var.shape
  shape_config_memory_in_gbs = var.shape_config_memory_in_gbs
  shape_config_ocpus         = var.shape_config_ocpus
  availability_domain        = var.availability_domain
  image_tag                  = var.image_tag

  depends_on = [module.vcn, module.network, module.key]
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      wireguard = module.instance.public_ip
      key       = var.key_name
      mobile    = var.mobile ? true : "False"
    }
  )
  filename = "../ansible/hosts.cfg"
  depends_on = [
    module.instance
  ]
}

resource "time_sleep" "wait_60_seconds" {
  depends_on      = [module.instance]
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

output "PUBLIC_IP" {
  value = module.instance.public_ip
}