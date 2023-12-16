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
  cluster_ca_certificate = base64decode(module.eks.cluster_cert)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}
