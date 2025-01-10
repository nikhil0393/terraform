terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.78.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # VERSION IS NOT NEEDED HERE
}

variable "application_name" {
  default = "07-backend-state"
}

variable "project_name" {
  default = "users"
}

variable "environment" {
  default = "dev"
}

terraform {
  backend "s3" {
    bucket         = "dev-applications-backend-state-in28minutes-xyz"
    #key            = "${var.application_name}-${var.project_name}-${var.environment}"
    #key            = "07-backend-state-users-dev"
    key            = "dev/07-backend-state/users/backend-state"
    region         = "us-east-1"
    dynamodb_table = "dev_application_locks"
    encrypt        = true
  }
}