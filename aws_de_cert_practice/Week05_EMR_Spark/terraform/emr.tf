resource "aws_emr_cluster" "week05_emr" {
  name          = "week05-emr-terraform"
  release_label = "emr-7.12.0"

  applications = [
    "Spark"
  ]

  service_role = aws_iam_role.emr_service_role.arn

  ec2_attributes {
    instance_profile = aws_iam_instance_profile.emr_ec2_instance_profile.arn
    subnet_id        = data.aws_subnets.default.ids[0]
  }

  master_instance_group {
    instance_type  = "m5.xlarge"
    instance_count = 1
  }

  core_instance_group {
    instance_type  = "m5.xlarge"
    instance_count = 1
  }

  log_uri = "s3://aws-logs-${data.aws_caller_identity.current.account_id}-us-east-1/elasticmapreduce/"

  termination_protection = false
  keep_job_flow_alive_when_no_steps = true

  tags = {
    Project = "Week05-EMR"
    Owner   = "learning"
  }

  # -----------------------------
  # Spark Step (SparkPi)
  # -----------------------------
    step {
        name              = "csv-to-parquet-step"
        action_on_failure = "TERMINATE_CLUSTER"

        hadoop_jar_step {
            jar = "command-runner.jar"

            args = [
            "spark-submit",
            "--deploy-mode", "cluster",
            "s3://yogesh-terraform-s3-mini-project-001/scripts/csv_to_parquet.py"
            ]
        }
    }

}
