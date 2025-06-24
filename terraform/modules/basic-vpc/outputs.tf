output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_id" {
  value = aws_subnet.public.id
}
output "public_route_table_id" {
  value = aws_route_table.public.id
}
output "private_subnet_id" {
  value = aws_subnet.private.id
}
# output "security_group_id" {
# value = aws_security_group.default.id
#}

output "private_vm_sg" {
  value = aws_security_group.private_vm_sg.id
}
output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
