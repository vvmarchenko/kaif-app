provider "aws" {
  profile = var.profile_name
  region  = var.region
  default_tags {
    tags = {
      Environment = "production"
      Owner       = "Vladyslav Marchenko"
      Project     = "kaif-app"
    }
  }
}

module "vpc" {
  source                    = "./module/vpc"
  region                    = var.region
  cidr_block                = var.cidr_block
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  availability_zones        = var.availability_zones
  vpc_name                  = var.vpc_name
}


module "eks_cluster" {
  source                       = "./module/eks_cluster"

  cluster_name                 = "kaif"
  node_group_name              = "kaif-node-group"
  subnet_ids                   = module.vpc.subnet_id
  ecr_repository_name          = "kaif-app-repository"
  node_group_desired_capacity  = 2
  node_group_max_capacity      = 2
  node_group_min_capacity      = 1
}