variable "vpc_name" {
  description = "Project Name"
  type = string
  default = "murali_aws_basic_vpc"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  default = "us-west-2a"
}

variable "vpc_cidr" {
  description = "Desired CIDR of VPC"
  type = string
  default = "10.0.1.0/24"
}
variable "region" {
  description = "AWS region to launch servers"
  type = string
  default = "us-west-2"
}
