provider "aws" {
  region = "ap-south-1"
}

terraform {
  required_version = "~> 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.0"
    }
  }

  backend "s3" {
    encrypt        = true
    dynamodb_table = "devops-redis-in-terraform-lock"
    bucket         = "devops-redis-in-terraform-states"
    key            = "sit-redis-cluster.tfstate"
    region         = "ap-south-1"
  }
}