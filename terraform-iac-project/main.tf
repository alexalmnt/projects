provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name = "my-vpc"
  public_subnet_count = 2
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}