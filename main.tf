
# This  is an Terraform configuration file

terraform {

# backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "SRE-PACK"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }

cloud {
    organization = "SRE-PACK"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}

# Random terraform Provider
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower   = true
  upper   = false
  length  = 32
  special = false
}

output "random_bucket_name" {
  value = random_string.bucket_name.result

}

# AWS S3 Bucket configuration template
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "my_bucket" {
  # Bucket Naming Rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result
  force_destroy = true
}