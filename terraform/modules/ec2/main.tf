resource "aws_key_pair" "mk_aws_key" {
  key_name   = "mk-aws-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "vm" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.default.id]
  key_name               = aws_key_pair.laptop_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.vpc_name}-ec2"
  }
}
