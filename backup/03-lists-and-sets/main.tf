variable "names" {
  default = ["ranga", "padma", "nikhila"]
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
    #count = length(var.names)
    #name = var.names[count.index]

    for_each = toset(var.names)
    name = each.value
}