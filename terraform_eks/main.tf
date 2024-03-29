# Define the provider
provider "aws" {
  region = var.region
}

# Retrieve all available AWS Availability Zones excluding local zones not supported by EKS
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Local variable to set the EKS cluster name
locals {
  cluster_name = "kaif-app-eks"
}

# Setup the VPC using the Terraform AWS VPC module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "kaif-vpc"
  cidr = "10.0.0.0/16"

  # Select the first three available AZs for the VPC
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  # Define subnet configurations for the VPC
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  # Enable and configure NAT gateway for outbound internet access from private subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Tag subnets for integration with EKS
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}

# Configure the EKS cluster and managed node groups using the Terraform EKS module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = local.cluster_name
  cluster_version = "1.29"

  # Specify VPC and subnet IDs for the EKS cluster
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Allow public access to the EKS cluster API endpoint
  cluster_endpoint_public_access = true

  # Set default configurations for managed node groups
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  # Define the managed node groups configurations
  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
    two = {
      name           = "node-group-2"
      instance_types = ["t3.micro"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }
}

# Retrieve the AWS IAM policy for EBS CSI driver
data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

# Setup IAM Role for Service Accounts (IRSA) for the EBS CSI driver
module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role = true
  role_name   = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"

  # OIDC provider URL from the EKS cluster for IRSA
  provider_url = module.eks.oidc_provider

  # Attach the retrieved EBS CSI policy to the role
  role_policy_arns = [data.aws_iam_policy.ebs_csi_policy.arn]

  # Define the service account that can assume this role
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}