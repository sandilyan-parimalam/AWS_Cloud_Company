terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">5.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host = module.eks.cluster_enpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.dev_web_eks_cluster.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.dev_web_eks_cluster.name]
    command     = "aws"
  }
}
