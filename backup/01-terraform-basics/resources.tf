#creating s3 bucket; plan; execute
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-terraform-002"
    versioning {
        enabled = true
    }
}

#Creating IAM user
resource "aws_iam_user" "my_iam_user" {
    name = "my_iam_user_abc_updated"
}