variable "aws_region" {
  type        = string
  description = "The name of the ECS cluster."
}

variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster."
}

variable "service_name" {
  type        = string
  description = "The base name of the ECS services."
}

variable "task_family" {
  type        = string
  description = "The base name of the ECS task families."
}

variable "ecr_repo_url_frontend" {
  type        = string
  description = "The ECR repository URL for the frontend image."
}

variable "ecr_repo_url_backend" {
  type        = string
  description = "The ECR repository URL for the backend image."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC."
}

variable "public_subnet_ids" { 
  type        = list(string)
  description = "A list of public subnet IDs for the ALB."
}

variable "private_subnet_id" {
  type        = string
  description = "The ID of the private subnet."
}

variable "load_balancer_sg_id" {
  type        = string
  description = "The ID of the load balancer security group."
}

variable "ecs_frontend_sg_id" {
  type        = string
  description = "The ID of the ECS frontend security group."
}

variable "ecs_backend_sg_id" {
  type        = string
  description = "The ID of the ECS backend security group."
}
