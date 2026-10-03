terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "migration"
      Environment = "devops"
      ManagedBy   = "Terraform"
    }
  }
}