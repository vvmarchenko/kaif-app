variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "node_group_desired_capacity" {
  description = "Desired number of nodes in the node group"
  type        = number
}

variable "node_group_max_capacity" {
  description = "Maximum number of nodes in the node group"
  type        = number
}

variable "node_group_min_capacity" {
  description = "Minimum number of nodes in the node group"
  type        = number
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "kaif-app-repository"
}