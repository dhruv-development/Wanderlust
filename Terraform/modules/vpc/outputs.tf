output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC."
}

output "public_subnet_ids" {
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id]
  description = "List of public subnet IDs."
}

output "private_subnet_id" {
  value       = aws_subnet.private_subnet.id
  description = "The ID of the private subnet."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gw.id
  description = "The ID of the internet gateway."
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat.id
  description = "The ID of the NAT gateway."
}

output "load_balancer_sg_id" {
  value       = aws_security_group.load_balancer.id
  description = "The ID of the load balancer security group."
}

output "ecs_frontend_sg_id" {
  value       = aws_security_group.ecs_frontend.id
  description = "The ID of the ECS frontend security group."
}

output "ecs_backend_sg_id" {
  value       = aws_security_group.ecs_backend.id
  description = "The ID of the ECS backend security group."
}
