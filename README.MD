## About The Project

This project goal to be simple to create and destroy your own VPN service using [WireGuard](https://www.wireguard.com/).

## Prerequisites

- Terraform
- Ansible
  
## How to Deploy

### Terraform 

Run with sudo is necessary because we need permission on localhost to install packages, configure a network interface and start a process.

You can change the region or key name in the variable.tf

* Initialize Terraform 

```bash
terraform init
```

* Plan our modifications

```bash
sudo terraform plan
```

* Apply the changes

```bash
sudo terraform apply
```

* Test the connection without VPN 
```bash
curl ipinfo.io/ip
```

* Start VPN 
```bash
sudo systemctl start wg-quick@wg0
```

* Test the connection with VPN 
```bash
curl ipinfo.io/ip
```

## 🧹 Cleanup

* Just run:

```bash
sudo terraform destroy
```

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues](https://github.com/P0ssuidao/terraguard/issues). 

## 🛣️ Roadmap

- ~~**Work🤣**~~
- ~~**Linux client(Debian and RedHat base)**~~
- ~~**Terraform to deploy server on AWS**~~
- **Linux client (other bases)**
- **Mac client**
- **Add other cloud providers**

## Author

👤 **João Freire**

* Twitter: [@p0ssuidao](https://twitter.com/p0ssuidao)
