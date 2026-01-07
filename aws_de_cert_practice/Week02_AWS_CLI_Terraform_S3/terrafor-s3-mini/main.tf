resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Project   = "S3-Mini-Project"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_access_point" "this" {
  name   = "yogesh-s3-mini-ap"
  bucket = aws_s3_bucket.this.id

}

data "aws_caller_identity" "current" {}


resource "aws_s3control_access_point_policy" "this" {
  access_point_arn = aws_s3_access_point.this.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_caller_identity.current.arn
        }
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_access_point.this.arn
        ]
      }
    ]
  })
}
