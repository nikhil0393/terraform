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
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
}