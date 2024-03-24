variable "profile_name" {
  default = "default"
  type    = string
}

variable "region" {
  default = "us-east-1"
  type    = string
}


variable "global_name" {
  default     = "kaif-app"
  type        = string
  description = "The global name for all project."
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for your VPC"
}

variable "public_subnet_cidr_blocks" {
  default = {
    "public_subnet1" = "10.0.1.0/24"
    "public_subnet2" = "10.0.2.0/24"
  }
  description = "List of CIDR blocks for the public subnets"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_name" {
  default     = "kaif_vpc"
  description = "Choose your VPC name"
  type        = string
}

variable "destination_cidr_block" {
  default     = "0.0.0.0/0"
  description = "The destination CIDR block for your route tables"
  type        = string
}