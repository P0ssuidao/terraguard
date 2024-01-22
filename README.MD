## About The Project

This project's goal is to be simple to create and destroy your own VPN service using [WireGuard](https://www.wireguard.com/).

## Prerequisites

- Terraform >= 1.0.0
- Ansible >= 2.10.5
  
## How to Deploy

### Terraform 

Run with sudo is necessary because we need permission on localhost to install packages, configure a network interface and start a process.

Select your cloud provider **AWS**, **DigitalOcean**, **GCP** and open the directory<br />

You can change the region or key name in the **variable.tf**
  
* Initialize Terraform 

```bash
sudo terraform init
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

* For GCP you need to declare your token(project_id) in **variable.tf** or command line:

```bash
sudo terraform plan -var "project_id=value"
sudo terraform apply -var "project_id=value"
```
You supply the key to Terraform using the environment variable GOOGLE_APPLICATION_CREDENTIALS:

```bash
export GOOGLE_APPLICATION_CREDENTIALS=path
```
* For AWS you need to configure your credentials using the follow command:
```bash
sudo aws configure
```
Or you can use your credentials as environment variable:
```bash
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```
* For OCI you need to configure your credentials using the following commands:
```bash
oci session authenticate --region us-ashburn-1 # the region is the same as TF_VAR_region (default us-ashburn-1)
export OCI_CLI_AUTH=security_token
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

## Mobile client 

If you want a extra client for mobile, you need to change the value of the variable **mobile** in **variable.tf** or command line:

```bash
sudo terraform plan -var "mobile=true"
sudo terraform apply -var "mobile=true"
```

If variable enabled it will be installed the package **qrencode** for generate a QRCODE with the configuration for configure in your mobile device.

After the execution it will be genered a QRCODE in stdout terraform, just scan in your mobile device.

Tested with the Android [WireGuard Client](https://play.google.com/store/apps/details?id=com.wireguard.android)

## 🧹 Cleanup

* Just run:

```bash
sudo terraform destroy
```

## ☁️ Cloud Providers
- ~~**AWS**~~
- ~~**Digital Ocean**~~
- ~~**GCP**~~
- **Azure**
- **OCI**
  
## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues](https://github.com/P0ssuidao/terraguard/issues). 

## 🛣️ Roadmap

- ~~**Work🤣**~~
- ~~**Linux client(Debian, RedHat and Arch base)**~~
- ~~**Terraform to deploy server on AWS**~~
- ~~**Mobile client**~~
- __**Mac client**__
- **Add other cloud providers**

## Author

👤 **João Freire**

* Twitter: [@p0ssuidao](https://twitter.com/p0ssuidao)
