variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "us-east-2"
}

variable "env" {
  description = "Environment of the project"
  type = string
}

variable "frontend_repo_name" {
  description = "AWS ECR Frontend Repository Name"
  type = string
}

variable "backend_repo_name" {
  description = "AWS ECR Backend Repository Name"
  type = string
}
