module "vpc" {
  source = "./modules/vpc"
}

module "budget" {
  source = "./modules/budget"
}

module "eks" {
  source = "./modules/eks"
  region = var.region
}
