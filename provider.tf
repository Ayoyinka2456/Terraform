#provider "aws" {
 # region = "us-east-2"
 # access_key = "AKIA5DLBVOZXMJATY3EX"
 # secret_key = "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"
#}

# Terraform Block
terraform {
  required_version = "~> 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Block 
provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
