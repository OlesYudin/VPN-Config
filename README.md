# <div align="center">VPN server using AWS Cloud provider</div>

This project create EC2 instance in AWS Cloud provider and configure OpenVPN Server.

Author of OpenVPN installer: [@angristan](https://github.com/angristan/openvpn-install "@angristan")

### <div align="center">Scheme of project:</div>

## Default configuration of EC2 instance:

| Option        | Value                                                    |
| ------------- | -------------------------------------------------------- |
| Region        | us-east-2                                                |
| Instance type | t2.micro                                                 |
| AWS user      | student                                                  |
| Open port     | 22 - your own Public IP; 2222 - default port for OpenVPN |
| SSH key name  | app_key.pub                                              |
| Volume type   | gp2                                                      |
| Volume size   | 8 GB                                                     |

## Guide for OpenVPN installer

To install the OpenVPN server, you must perform the following steps, which are performed automatically in this project using the [script.sh](https://github.com/OlesYudin/VPN-Config/blob/main/scripts/script.sh "script.sh") file.

```
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod u+x openvpn-install.sh
sudo ./openvpn-install.sh
```

But, in this case you need manualy configure server.
For automatic installation, you need to pass variables along with the installation command

**<div align="center">List of variables that pass with installation command (y=yes; n=no):</div>**

| Variable            | Value                  | Description                                                                                                                |
| ------------------- | ---------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| AUTO_INSTALL        | y                      | For auto installation                                                                                                      |
| APPROVE_INSTALL     | y                      |                                                                                                                            |
| APPROVE_IP          | y                      |                                                                                                                            |
| ENDPOINT            | $(curl -4 ifconfig.co) | This variable take public IP address of EC2 instance and give it to script                                                 |
| IPV6_SUPPORT        | n                      | Dont support IPv6                                                                                                          |
| PORT_CHOICE         | 2                      | If you want default IP - PORT_CHOICE=1, default port will be - 1194. If you want manual port - PORT_CHOICE=2, PORT=1-65535 |
| PORT                | 2222                   | Default port: 2222                                                                                                         |
| PROTOCOL_CHOICE     | 1                      | This script support only UDP traffic (1 - UDP; 2 - TCP)                                                                    |
| DNS                 | 8                      | By default use Google.com DNS                                                                                              |
| COMPRESSION_ENABLED | n                      |                                                                                                                            |
| CUSTOMIZE_ENC       | n                      |                                                                                                                            |
| CLIENT              | user                   | Default username: user                                                                                                     |
| PASS                | 1                      | BE CAREFULL for default: WITHOUT PASSWORD (1 - w/o password; 2 - with password)                                            |

Example of command to automaticaly install:

```
sudo AUTO_INSTALL=y APPROVE_INSTALL=y ENDPOINT=$(curl -4 ifconfig.co) APPROVE_IP=y IPV6_SUPPORT=n PORT_CHOICE=2 PORT=2222 PROTOCOL_CHOICE=1 DNS=8 COMPRESSION_ENABLED=n CUSTOMIZE_ENC=n CLIENT=student PASS=1 ./openvpn-install.sh
```
