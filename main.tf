provider "aws" {
  region  = var.region
  profile = var.profile
}

# Default AMI for EC2
# This  block will get AMI of latest ubuntu 16.04 and give this value to block of "aws_instance"
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Security group for EC2 instance
# By default open:
# 22 port - SSH connection
# 2222 port - port for OpenVPN Server
resource "aws_security_group" "sg_vpn" {
  name        = "SG-SSH_VPN"
  description = "Allow SSH and VPN connection"

  # Inbound rules for 22,2222 ports
  # Open 22 to my IP
  # Open 2222 to all in the Internet
  dynamic "ingress" {
    for_each = var.sg_port
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SG-SSH_VPN"
  }
}

# Creating EC2 instance for VPN server
# This block create EC2 instance with default values, that can be changed in file "variables.tf"
# Linux image: Ubuntu 16.04 Latest
# Instance type: t2.micro
# Public IP: true
# Open ports: 22, 2222
# Key for SSH connection: app_key.pem
# Volume: 8 GB of gp2
# User_data: update and install openvpn server
resource "aws_instance" "vpn" {
  ami                         = data.aws_ami.ubuntu.id         # Get ami from data, by default "Ubuntu 16.04"
  instance_type               = var.instance_type              # Choose instance type. By default "t2.micro"
  associate_public_ip_address = true                           # Give public IP to instance
  vpc_security_group_ids      = [aws_security_group.sg_vpn.id] # Attache SG to EC2. By defaulr open port 22, 2222
  key_name                    = var.ssh_key                    # Change value of this variable before apply
  user_data                   = file("./scripts/script.sh")    # Script that run with installation EC2 

  # Configuration of memory
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 0
    throughput            = 0
    volume_size           = var.volume_size # Min size of EC2
    volume_type           = "gp2"
  }

  tags = {
    Name        = "VPN"
    Description = "OpenVPN Server based on Ubuntu 16.04"
  }
}
