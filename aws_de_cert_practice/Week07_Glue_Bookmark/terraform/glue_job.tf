resource "aws_glue_job" "etl_job" {
  name     = "week07-glue-etl"
  role_arn = aws_iam_role.glue_role.arn

  glue_version = "4.0"
  worker_type  = "G.1X"
  number_of_workers = 2
  max_retries  = 0
  timeout      = 10

  command {
    name            = "glueetl"
    script_location = "s3://${var.bucket_name}/scripts/glue_etl_users.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-bookmark-option" = "job-bookmark-enable"
    "--INPUT_DB"           = aws_glue_catalog_database.raw_db.name
    "--INPUT_TABLE"        = "users"
    "--OUTPUT_PATH"        = "s3://${var.bucket_name}/${var.curated_prefix}users/"
  }
}
