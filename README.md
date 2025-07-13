# AWS Data Engineer Certification Roadmap

This repository contains a **12‑week, hands‑on** learning path to master AWS data engineering and pass the DEA‑C01 certification. Follow the steps below to bootstrap and structure your work.

## Weeks

Each week folder will be auto-created by the setup script below. The titles listed here are used to name the directories:

```
week01_data_fundamentals_and_sql/
week02_cli_and_terraform/
week03_iam_networking_encryption/
week04_spark_hadoop_local/
week05_emr_and_spark_on_aws/
week06_s3_and_glue_catalog/
week07_glue_etl_pyspark/
week08_redshift_deep_dive/
week09_serverless_and_streaming/
week10_airflow_orchestration/
week11_monitoring_logging_security/
week12_exam_prep_and_mocks/
```

## Full Setup Guide

> **Prerequisites:** Git, AWS CLI v2, Terraform v1.x, SSH access to remote EC2

1. **Clone the repo locally**

   ```bash
   git clone https://github.com/your-org/aws-data-engineer-certification-roadmap.git
   cd aws-data-engineer-certification-roadmap
   ```

2. **SSH into your remote instance and pull the repo**

   ```bash
   ssh -i /path/to/key.pem ec2-user@YOUR_EC2_IP
   mkdir -p ~/projects && cd ~/projects
   git clone https://github.com/your-org/aws-data-engineer-certification-roadmap.git
   cd aws-data-engineer-certification-roadmap
   ```

3. **Auto-create week folders**

   ```bash
   for i in $(seq -w 1 12); do
     title=$(grep -oP "(?<=week${i}_)[^/]+" README.md)
     mkdir -p week${i}_${title}/{docs,scripts,labs}
   done
   ```

4. **Initialize branches**

   ```bash
   for i in $(seq -w 1 12); do
     git checkout -b week${i}-start
   done
   git checkout main
   ```

5. **AWS CLI & Terraform**

   * Run `aws configure` to set up your credentials.
   * In each `weekNN_*` folder as needed:

     ```bash
     terraform init
     terraform plan
     terraform apply
     ```

6. **Weekly Workflow**
   For each week `NN`:

   ```bash
   git checkout week${NN}-start
   # Watch lectures & complete hands-on labs
   git add . && git commit -m "[Wk${NN}] Completed deliverables"
   git tag v1-week${NN}
   git checkout main
   git merge --no-ff week${NN}-start
   ```

7. **Finalize**

   ```bash
   git checkout main
   git merge --no-ff week12-start
   git tag v1-complete
   ```

You’re now ready to follow a clear, reproducible path to AWS Data Engineer certification success. Happy learning!
