# Global variable - can be overridden
variable "environment" {
  default = "default"
}

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

#Creating IAM user
resource "aws_iam_user" "my_iam_user" {
    name = "${locals.iam_user_extension}_${var.environment}"
}

# Like local variable, cannot be overridden from other modules
locals {
  iam_user_extension = "my_iam_user_abc"
}