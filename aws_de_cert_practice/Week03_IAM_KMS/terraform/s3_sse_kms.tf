 # Apply SSE-KMS encryption to an existing S3 bucket (created in Week 2)

resource "aws_s3_bucket_server_side_encryption_configuration" "week03_sse_kms" {
  bucket = "yogesh-terraform-s3-mini-project-001"  # existing bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.this.arn
    }
  }
}
