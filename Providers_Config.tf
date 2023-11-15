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
  backend "s3" {
    bucket = "terraformstatefilestore"
    key = "terraform.tfstate"
    region = var.region
  }

}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
