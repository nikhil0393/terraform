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

variable "ami" {
  description = "This is used for ec2 creation"
}

variable "instance_type" {
  description = "This is the instance_type value for ec2 creation"
  type        = map(string)

  default = {
    "dev"   = "t2.micro"
    "stage" = "t2.medium"
    "prd"   = "t2.xlarge"
  }
}

module "ec_instance" {
  source = "./modules/ec2_instance"
  ami    = var.ami
  #   instance_type = var.instance_type
  instance_type = lookup(var.instance_type, terraform.workspace, t2.micro)
}