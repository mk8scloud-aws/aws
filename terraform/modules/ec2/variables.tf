variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for your region"
  default     = "ami-05f991c49d264708f" # Example: Ubuntu 22.04 in us-west-2, Free Tier
}

variable "public_key_path" {
  description = "Path to your SSH public key file"
  default     = "~/.ssh/id_rsa.pub"
}
