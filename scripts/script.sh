#!/bin/bash
# https://www.youtube.com/watch?v=Hqr-c9LUeFs&t=606s

sudo apt update && sudo apt -y dist-upgrade && sudo apt -y full-upgrade

mkdir vpn && cd vpn/
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod u+x openvpn-install.sh

# Environment variables for automaticly install
# AUTO_INSTALL=y
# APPROVE_INSTALL=y
# APPROVE_IP=y
# ENDPOINT=$(curl -4 ifconfig.co) # This variable take public IP address of EC2 instance and give it to script
# IPV6_SUPPORT=n
# PORT_CHOICE=2 # If you want default IP - PORT_CHOICE=1, default port will be - 1194. If you want manual port - PORT_CHOICE=2, PORT=1-65535
# PORT=2222 # Default port: 2222
# PROTOCOL_CHOICE=1
# DNS=8 # Default DNS: Google.com
# COMPRESSION_ENABLED=n
# CUSTOMIZE_ENC=n
# CLIENT=user # Default username: user
# PASS=1 # BE CAREFULL for default: WITHOUT PASSWORD

sudo AUTO_INSTALL=y APPROVE_INSTALL=y ENDPOINT=$(curl -4 ifconfig.co) APPROVE_IP=y IPV6_SUPPORT=n PORT_CHOICE=2 PORT=2222 PROTOCOL_CHOICE=1 DNS=8 COMPRESSION_ENABLED=n CUSTOMIZE_ENC=n CLIENT=user PASS=1 ./openvpn-install.sh

# Move OpenVPN config to root folder of ubuntu user
mv /root/user.ovpn /home/ubuntu/