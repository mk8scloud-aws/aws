resource "aws_key_pair" "mk_aws_key" {
  key_name   = "mk-aws-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "vm" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.mk_aws_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.vpc_name}-ec2"
  }
}
