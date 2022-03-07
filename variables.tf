# Default region
variable "region" {
  default = "us-east-2"
}
# Default profile
variable "profile" {
  default = "student" # Change your profile to "default" if you have only one aws user in .aws/credentials
}

# EC2
# Default instance type for EC2
variable "instance_type" {
  default = "t2.micro"
}
# Size of volume in EC2
variable "volume_size" {
  default = 8
}
# Default key for SSH connection
variable "ssh_key" {
  default = "app_key" # Create ssh key on AWS Console and write name of this key to this variable
}

# Security group
# Open port for SG
variable "sg_port" {
  description = "Allowed EC2 ports"
  type        = map(any)
  default = {
    "22"   = ["0.0.0.0/0"] # Change this CIDR to your own public IP (Example: 18.56.143.12/32)
    "2222" = ["0.0.0.0/0"] # Open port 2222 to all internet
  }
}
