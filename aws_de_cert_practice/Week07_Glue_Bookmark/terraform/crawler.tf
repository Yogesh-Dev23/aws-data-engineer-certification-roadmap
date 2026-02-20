resource "aws_glue_crawler" "raw_crawler" {
  name          = "week07-raw-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.raw_db.name

  s3_target {
    path = "s3://${var.bucket_name}/${var.raw_prefix}"
  }
}

resource "aws_glue_crawler" "curated_crawler" {
  name          = "week07-curated-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.curated_db.name

  s3_target {
    path = "s3://${var.bucket_name}/${var.curated_prefix}"
  }
}
