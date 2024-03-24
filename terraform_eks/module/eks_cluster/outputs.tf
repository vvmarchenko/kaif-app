output "cluster_id" {
  value       = aws_eks_cluster.this.id
  description = "The ID of the EKS cluster"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "The endpoint for your EKS Kubernetes API"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.this.certificate_authority[0].data
  description = "The base64 encoded certificate data required to communicate with your cluster"
}

output "node_group_id" {
  value       = aws_eks_node_group.this.id
  description = "The ID of the EKS node group"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
  description = "The URL of the ECR repository"
}