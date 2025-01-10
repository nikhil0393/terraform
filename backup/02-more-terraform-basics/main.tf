variable "iam_user_name_prefix" {
    type = string #any, string, number, bool, list, map, set, object, tuple
    default = "my_iam_user"
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
resource "aws_iam_user" "my_iam_users" {
    count = 1
    name = "${var.iam_user_name_prefix}_${count.index}"
}