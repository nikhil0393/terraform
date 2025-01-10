variable "users" {
  default = {
    nikhila : { country : "US", department : "ABC" },
    padma : { country : "India", department : "PQR" },
    ranga : { country : "Netherlands", department : "XYZ" }

    #ranga:"Netherlands"
  }
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
  #For Map
  for_each = var.users
  name     = each.key
  tags = {
    country : each.value.country #used for Map of Maps
    department : each.value.department
    #country: each.value
  }

  #Used for List
  #for_each = toset(var.names)
  #name = each.value
}