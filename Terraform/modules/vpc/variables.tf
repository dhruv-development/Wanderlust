variable "vpc_cidr"{
	description = "VPC CIDR Range"
	type = string
}

variable "public_subnet_cidr_1"{
        description = "VPC Subnet CIDR Range"
        type = string
}

variable "public_subnet_cidr_2" {
  type        = string
  description = "CIDR block for the second public subnet."
}

variable "public_subnet_cidr_3" {
  type        = string
  description = "CIDR block for the second public subnet."
}

variable "private_subnet_cidr"{
        description = "VPC Subnet CIDR Range"
        type = string
}

variable "availability_zone1"{
        description = "VPC availability zone"
        type = string
}

variable "availability_zone2"{
        description = "VPC availability zone"
        type = string
}

variable "availability_zone3"{
        description = "VPC availability zone"
        type = string
}

variable "vpc_name" {
        description = "VPC name"
        type = string
}

variable "env" {
        description = "VPC environment"
        type = string
}
