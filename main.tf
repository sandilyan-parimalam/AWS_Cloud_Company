module "vpc" {
  source = "./modules/vpc"
}

module "budget" {
  source = "./modules/budget"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source = "./modules/eks"
  region = var.region
}
