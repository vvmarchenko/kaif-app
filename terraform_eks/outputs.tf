output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

output "ecr_repository_url" {
value = module.eks_cluster.ecr_repository_url
}

output "eks_cluster_id" {
  value = module.eks_cluster.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks_cluster.cluster_certificate_authority_data
}

output "eks_node_group_id" {
  value = module.eks_cluster.node_group_id
}