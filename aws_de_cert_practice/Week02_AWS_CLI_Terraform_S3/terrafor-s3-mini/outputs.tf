output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "access_point_arn" {
  value = aws_s3_access_point.this.arn
}