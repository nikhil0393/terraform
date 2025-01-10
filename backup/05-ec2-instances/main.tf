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
  # region = "us-east-1"
  region = var.aws_region

  # VERSION IS NOT NEEDED HERE
}

# default VPC
resource "aws_default_vpc" "default" {}

# HTTP Server
# SG -> 80 TCP, 22 TCP, CIDR ["0.0.0.0/0"] 

# Security group creation for the VPC
resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"

  # vpc_id = "vpc-0b4e69460b1b48a5e"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}

# AWS EC2 instance creation
resource "aws_instance" "http_server" {
  # ami                    = "ami-0166fe664262f664c"
  ami = data.aws_ami.aws_linux_2_latest.id
  # key_name               = "default-ec2"
  key_name = var.key_name

  # instance_type          = "t2.micro"
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  # subnet_id              = "subnet-07139f9f39edbe50f"
  subnet_id = tolist(data.aws_subnets.default_subnets.ids)[0]

  #to connect to ec2 instance
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  #to run commands on ec2
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                             //install httpd
      "sudo service httpd start",                                                                              //start the server
      "echo Welcome to in28min - Virtual server is at ${self.public_dns}  | sudo tee /var/www/html/index.html" //copy a file
    ]
  }
}