# To get list of subnets under a VPC
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

# for getting AMI dynamically
data "aws_ami" "aws_linux_2_latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name = "name"
    # values = ["amzn2-ami-hvm-*"]
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami_ids" "aws_linux_2_latest_ids" {
  # owners = ["amazon"]
  owners = var.owners
}