module "vpc" {
  source = "./modules/vpc"
}

module "budget" {
  source = "./modules/budget"
}
module "eks" {
  source = "./modules/eks"
  my_current_region  = output.aws_region_name
}
