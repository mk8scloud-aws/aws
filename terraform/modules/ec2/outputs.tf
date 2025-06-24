output "ec2_public_ip" {
  value = aws_instance.vm.public_ip
}
output "ec2_private_ip" {
  value = aws_instance.vm.private_ip
}
#output "private_subnet_id" {
#  value = aws_subnet.private.id
#}