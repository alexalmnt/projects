terraform {
  required_version = ">= 1.10.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.82.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# remote backend
terraform {
  backend "s3" {
    bucket         = "inbound-bucket-terra"
    key            = "lambda-function/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}