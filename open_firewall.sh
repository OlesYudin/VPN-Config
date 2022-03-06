#!/bin/bash

# --------------------------------------------------------+
# Be carefull this script will run on your local machine! |
# --------------------------------------------------------+

# This script will activate UFW and open SSH port for installing OpenVPN config for EC2 instance
# Update and upgrade local machine
sudo apt update && sudo apt -y dist-upgrade && sudo apt -y full-upgrade
# Install UFW
sudo apt install -y ufw
# Allow 22 port for all Internet
sudo ufw allow 22/tcp
# Enable UFW
sudo ufw enable
# Restart UFW
sudo systemctl restart ufw