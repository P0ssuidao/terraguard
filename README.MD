## About The Project

This project's goal is to be simple to create and destroy your own VPN service using [WireGuard](https://www.wireguard.com/).

## Prerequisites

- Terraform >= 1.0.0
- Ansible >= 2.10.5
  
## How to Deploy

### Terraform 

Run with sudo is necessary because we need permission on localhost to install packages, configure a network interface and start a process.

Select your cloud provider **AWS**, **DigitalOcean** and open the directory<br />

You can change the region or key name in the **variable.tf**
  
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
* For Digital Ocean you need to declare your token(do_token) in **variable.tf** or command line:

```bash
sudo terraform plan -var "do_token=value"
sudo terraform apply -var "do_token=value"
```
## Tests - Checking the IP

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

## ☁️ Cloud Providers
- ~~**AWS**~~
- ~~**Digital Ocean**~~
- **GCP**
- **OCI**
  
## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues](https://github.com/P0ssuidao/terraguard/issues). 

## 🛣️ Roadmap

- ~~**Work🤣**~~
- ~~**Linux client(Debian, RedHat and Arch base)**~~
- ~~**Terraform to deploy server on AWS**~~
- **Mac client**
- **Add other cloud providers**

## Author

👤 **João Freire**

* Twitter: [@p0ssuidao](https://twitter.com/p0ssuidao)
