terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }

  backend "s3" {
    bucket         = "incident-response-bot-tfs-" # S3 bucket for storing the Terraform state files 
    region         = "eu-north-1"  # AWS region for the S3 bucket
    key            = "env/prod/terraform.tfstate" # Path within the bucket to store the state file 
    dynamodb_table = "incident-response-tf-lock-state-files" # DynamoDB table for state locking with partition key 'LockID'
    encrypt        = true
  }

}

provider "aws" {
  region = var.region
}