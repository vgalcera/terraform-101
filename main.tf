resource "aws_s3_bucket" "example_bucket" {
    bucket = var.bucket_name

    tags = {
       Environment = "Dev"
       Project = "Terraform-101"
    }
}

resource "aws_s3_object" "bucket_object" {
    bucket = aws_s3_bucket.example_bucket.id
    key = "bucket-obj-hello-world"
    source = "hello-world.html"
    content_type = "text/html"
}