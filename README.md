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
