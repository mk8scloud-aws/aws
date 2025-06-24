#variable "public_key_path" {
#  description = "Path to your public SSH key"
#  type        = string
#}

#variable "ami_id" {
#  description = "AMI ID for the EC2 instance"
#  type        = string
#}

module "vpc" {
  source              = "./modules/basic-vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  vpc_name            = "mk-aws-vpc"
  availability_zone   = "us-west-2a"
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = "ami-05f991c49d264708f"
  instance_type     = "t2.micro"
  public_key_path   = var.public_key_path
  vpc_name          = "mk-aws-vpc"
  public_subnet_id  = module.vpc.public_subnet_id
#  security_group_id = module.vpc.security_group_id
  security_group_id = module.vpc.bastion_sg_id
  private_subnet_id = module.vpc.private_subnet_id
  private_vm_sg     = module.vpc.private_vm_sg
}
