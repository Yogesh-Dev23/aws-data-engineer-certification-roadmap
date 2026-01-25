# Week 05 — Amazon EMR + Spark (Hands-on Notes)

## Goal of Week 5
- Run Apache Spark on Amazon EMR
- Use Terraform for full cluster lifecycle
- Execute real Spark jobs (CSV → transform → Parquet → S3)
- Understand EMR, YARN, Spark logs, and cost control

---

## EMR Core Concepts

### What is Amazon EMR
- Managed big data platform on AWS
- Runs frameworks like Spark, Hadoop, Hive, etc.
- EMR manages:
  - EC2 instances
  - YARN
  - HDFS (optional)
  - Spark installation

---

### EMR Node Types
- **Master node**
  - Runs YARN ResourceManager
  - Runs Spark Driver (in client mode)
  - Cluster coordination
- **Core node**
  - Runs Spark executors
  - Provides HDFS storage
- **Task node**
  - Optional, compute-only (no HDFS)

---

## Spark on EMR Architecture

spark-submit
↓
YARN ResourceManager
↓
ApplicationMaster
↓
Spark Executors (on core/task nodes)


- Spark runs **on YARN** by default on EMR
- Spark does NOT manage resources directly

---

## Deploy Modes

### Cluster Mode (Used)
- Driver runs inside YARN container
- Production-style
- Driver logs NOT always visible in EMR step logs

### Client Mode
- Driver runs on EMR master node
- Easier debugging
- Not recommended for production

---

## IAM Roles in EMR (Critical)

### 1. EMR Service Role
- Assumed by EMR service
- Used to:
  - Create EC2
  - Manage networking
  - Control cluster lifecycle

### 2. EMR EC2 Instance Profile
- Attached to all EMR EC2 nodes
- Used by:
  - Spark jobs
  - S3 read/write
  - Log uploads

📌 Spark never uses IAM users.

---

## Terraform + EMR

### Key Terraform Resource
- `aws_emr_cluster`

### Spark Steps
- Defined **inside** `aws_emr_cluster`
- Use `command-runner.jar`
- Terraform does NOT run Spark
- Terraform only tells EMR **what to run**

---

## Spark Step Structure

```hcl
step {
  name = "spark-job"

  hadoop_jar_step {
    jar = "command-runner.jar"
    args = [
      "spark-submit",
      "--deploy-mode", "cluster",
      "s3://bucket/script.py"
    ]
  }
}


Spark Job Learnings
CSV Reading

CSV columns are strings by default

Aggregations require explicit casting

df = df.withColumn("amount", col("amount").cast("int"))


Lazy Evaluation

Spark transformations are lazy

Actions like .count() force execution

Useful for debugging stages

Logging & Debugging on EMR
EMR Step Logs (S3)

elasticmapreduce/
└── j-CLUSTER_ID/
    └── steps/
        └── s-STEP_ID/
            ├── controller.gz
            ├── stderr.gz
            └── stdout.gz (optional)

controller.gz

EMR orchestration

spark-submit execution

stderr.gz

Spark/YARN logs

Python exceptions (if surfaced)

stdout.gz

May not exist for short jobs

Why print() Didn’t Appear

Spark ran in cluster deploy mode

Driver logs go to YARN container logs

EMR step logs mainly show:

YARN lifecycle

Exit codes

📌 This is expected behavior.

Common EMR + Spark Errors Encountered
1. Wrong S3 URI

❌ s3:/bucket/path
✅ s3://bucket/path

2. Schema Issues

Aggregating string columns causes runtime failure

Must cast explicitly

3. Logs Not Visible

Short jobs may not upload stdout

Logs may be delayed

Cluster termination can stop log shipping

Cost Control Best Practices

Use small instance types

Use action_on_failure = TERMINATE_CLUSTER

Destroy cluster immediately after validation

Logs in S3 cost pennies, compute costs dollars

terraform destroy

Key Mental Models (Exam + Real Life)

EMR manages infrastructure, Spark runs jobs

Spark on EMR always runs on YARN

EMR step success = exit code 0

Data output > logs > UI

Infrastructure bugs ≠ data bugs

Week 5 Outcome

✔ Spark job executed on EMR
✔ Terraform-managed lifecycle
✔ CSV → transform → Parquet → S3
✔ Debugged real Spark failures
✔ Understood EMR logging behavior

Week 5 COMPLETE

