variable "public_key_path" {
  description = "Path to your public SSH key"
  type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}
variable "security_group_id" {
  description = "Security group ID for public (bastion) instance"
  type        = string
}

variable "private_vm_sg" {
  description = "Security group ID for private VM"
  type        = string
}
