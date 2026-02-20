resource "aws_athena_workgroup" "analytics" {
  name = "analytics-wg"

  configuration {
    enforce_workgroup_configuration = true

    result_configuration {
      output_location = "s3://yogesh-terraform-s3-mini-project-001/athena-results/analytics-wg/"


      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }

  tags = {
    Environment = "dev"
    Project     = "data-engineering"
    Owner       = "yogesh"
  }
}
