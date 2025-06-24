

variable "ami_id" {
  type        = string
  description = "AMI ID to launch EC2"
   default     = "ami-05f991c49d264708f" # Example: Ubuntu 22.04 in us-west-2, Free Tier
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "public_key_path" {
  type        = string
  description = "Path to the SSH public key file"
}

variable "vpc_name" {
  type        = string
  description = "VPC name tag"
}

variable "public_subnet_id" {
  type        = string
  description = "ID of the public subnet"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet ID for the internal Ubuntu VM"
}
variable "private_vm_sg" {
  type        = string
  description = "Private Security Group for the internal Ubuntu VM"
}

variable "security_group_id" {
  description = "Security group ID for public (bastion) instance"
  type        = string
}
