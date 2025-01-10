variable "aws_key_pair" {
  default = "C:/Users/Sainikhil Myana/aws/aws_keys/default-ec2.pem"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "owners" {
  default = ["amazon"]
}

variable "key_name" {
  default = "default-ec2"
}

variable "instance_type" {
  default = "t2.micro"
}