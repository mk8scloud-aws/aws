#variable "public_key_path" {
#  description = "Path to your public SSH key"
#  type        = string
#}

#variable "ami_id" {
#  description = "AMI ID for the EC2 instance"
#  type        = string
#}

/*
module "vpc" {
  source              = "./modules/basic-vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  vpc_name            = "mk-aws-vpc"
  availability_zone   = "us-west-2a"
}

module "ec2" {
  source           = "./modules/ec2"
  ami_id           = "ami-05f991c49d264708f"
  instance_type    = "t2.micro"
  public_key_path  = var.public_key_path
  vpc_name         = "mk-aws-vpc"
  public_subnet_id = module.vpc.public_subnet_id
  #  security_group_id = module.vpc.security_group_id
  security_group_id = module.vpc.bastion_sg_id
  public_vm_sg      = module.vpc.bastion_sg_id
  private_subnet_id = module.vpc.private_subnet_id
  private_vm_sg     = module.vpc.private_vm_sg
}
*/

##deepseek

# Read the existing public key file
locals {
  ssh_public_key = file("/Users/murali.kanaga/.ssh/id_ed25519.pub")
}

# Create AWS key pair using your existing public key
resource "aws_key_pair" "my_key" {
  key_name   = "murali-key" # Choose a name for your AWS key pair
  public_key = local.ssh_public_key
}



module "vpc" {
  source              = "./modules/basic-vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  vpc_name            = "mk-aws-vpc"
  availability_zone   = "us-west-2a"
}

resource "aws_security_group" "public_instance" {
  name        = "public-instance-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_instance" {
  name        = "private-instance-sg"
  description = "Allow SSH from VPC and all outbound"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    #  cidr_blocks = [module.vpc.vpc_cidr]
    #  cidr_blocks = [var.vpc_cidr]
    cidr_blocks = [module.vpc.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "public_instance" {
  source = "./modules/ec2-instance"
  #  ami_id             = "ami-05f991c49d264708f"
  instance_type      = "t2.micro"
  instance_name      = "public-instance"
  subnet_id          = module.vpc.public_subnet_id
  is_public          = true
  key_name           = aws_key_pair.my_key.key_name
  security_group_ids = [aws_security_group.public_instance.id]
}

module "private_instance" {
  source = "./modules/ec2-instance"
  #  ami_id             = "ami-05f991c49d264708f"
  instance_type      = "t2.micro"
  instance_name      = "private-instance"
  subnet_id          = module.vpc.private_subnet_id
  is_public          = false
  key_name           = aws_key_pair.my_key.key_name
  security_group_ids = [aws_security_group.private_instance.id]
}