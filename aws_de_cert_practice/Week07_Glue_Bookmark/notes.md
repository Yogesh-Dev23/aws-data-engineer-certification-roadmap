# Week 07 – AWS Glue ETL (DEA-C01 Notes)

## Objective
Design and validate a **production-style AWS Glue ETL pipeline** using:
- Raw → Curated data zones
- Glue Crawlers & Data Catalog
- Glue Spark ETL (PySpark)
- Job Bookmarks (incremental processing)
- Safe S3 write patterns

Focus is on **design correctness, failure safety, and exam relevance**, not Terraform.

---

## High-Level Architecture

Raw data arrives in Amazon S3 and is processed incrementally using AWS Glue.

Flow:
Raw S3  
→ Glue Crawler (raw schema discovery)  
→ Glue Data Catalog (raw tables)  
→ Glue ETL Job (Spark, DynamicFrame, bookmarks)  
→ Curated S3 (partitioned Parquet)  
→ Glue Crawler (curated schema)  
→ Analytics (Athena / Redshift Spectrum)

---

## Data Zones

### Raw Zone
Characteristics:
- Append-only
- Immutable
- Minimal or no transformations
- Preserved for reprocessing

Example:
s3://bucket/raw/users/input.csv

---

### Curated Zone
Characteristics:
- Cleaned and typed schema
- Analytics-ready
- Partitioned
- Written by Glue ETL jobs

Example:
s3://bucket/curated/users/country=IN/

---

## Glue Crawlers Strategy

### Raw Crawler
- Points to raw S3 paths
- Discovers evolving schemas
- Creates tables in a raw Glue database
- Runs on schedule or on demand

Purpose:
Schema discovery only (no transformation).

---

### Curated Crawler
- Points to curated S3 paths
- Discovers partitions and final schema
- Creates analytics-ready tables

Purpose:
Register curated datasets for Athena / Redshift.

---

### Important Rule
Do NOT use one crawler for both raw and curated zones.
This causes schema conflicts and unstable tables.

---

## Glue ETL Job Design

### Responsibilities
- Read raw data from Glue Catalog
- Normalize schema (type casting, validation)
- Apply deterministic transformations
- Write curated data to S3
- Support incremental processing

Glue ETL should NOT:
- Modify raw data
- Perform streaming logic
- Contain application business logic
- Replace Athena or EMR

---

## DynamicFrame vs DataFrame

### DynamicFrame
- Glue-native abstraction
- Schema-flexible
- Required for job bookmarks
- Handles schema evolution

### DataFrame
- Native Spark API
- Faster and richer transformations

Best Practice:
Read data as DynamicFrame, convert to DataFrame for transformations.

---

## Job Bookmarks (Incremental Processing)

### What Job Bookmarks Do
- Track previously processed input data
- Enable incremental processing
- Prevent re-reading old raw data

### What Job Bookmarks Track
- S3 file paths
- Modification timestamps
- Catalog partitions (if present)

### What Job Bookmarks Do NOT Do
- Deduplicate output
- Control overwrite behavior
- Roll back partial writes

---

### Bookmark Modes
- Enable: normal incremental processing
- Disable: full reprocessing every run
- Pause: read bookmark but do not update state

---

### Bookmark Requirements
All must be true:
- GlueContext is used
- Input read via DynamicFrame
- Input comes from Glue Catalog or Glue source
- Job bookmarks are enabled in job settings

Bookmarks do NOT work with spark.read.csv().

---

## S3 Write Semantics in Glue (Very Important)

Glue uses Spark, and Spark treats S3 like a filesystem.

### Overwrite Mode
- Deletes existing objects in target prefix
- Deletes S3 folder marker objects
- Requires s3:DeleteObject permission
- High risk and expensive

Overwrite is dangerous by default.

---

### Append Mode (Recommended)
- Writes new files only
- Does not delete existing data
- Safer with retries
- Lower IAM complexity

Best practice:
Use append mode with partitioned writes.

---

## Partitioned Writes

Partitioning example:
partitionBy("country")

Results in:
s3://bucket/curated/users/country=IN/
s3://bucket/curated/users/country=US/

Benefits:
- Reduces overwrite scope
- Improves Athena query performance
- Safer incremental writes

Catalog partitions are metadata-only and do NOT control Spark parallelism.

---

## Failure and Retry Behavior

### On Failure
- Job bookmark state is NOT updated
- Input may be reprocessed on retry
- Output may be partially written

### Retry Risks
- Append mode can duplicate data
- Overwrite mode can delete valid data

Recommended strategy:
- Retries: 0 or 1
- Prefer fixing the issue and rerunning manually

Glue does not provide transactional guarantees.

---

## Job Parameters

Purpose:
Make Glue jobs reusable and environment-agnostic.

Typical parameters:
- INPUT_DB
- INPUT_TABLE
- OUTPUT_PATH
- PARTITION_COL
- ENV

Important:
Job bookmarks are tied to job name, NOT parameter values.

Changing parameters does NOT reset bookmarks.

---

## IAM Considerations

AWS managed Glue role does NOT grant access to your S3 data.

Glue job role must allow:
- s3:ListBucket
- s3:GetObject
- s3:PutObject
- s3:DeleteObject (required for overwrite)

Spark overwrite may attempt to delete S3 folder marker objects.

---

## Glue vs EMR (Exam Summary)

Use AWS Glue when:
- Serverless ETL is required
- Schema discovery is needed
- Incremental batch processing
- Low operational overhead

Use Amazon EMR when:
- Full Spark/Hadoop control is required
- Custom tuning is needed
- Long-running or complex jobs

Exam shortcut:
ETL + serverless + metadata → Glue  
Control + tuning + cluster → EMR

---

## Exam Traps to Remember

- Crawlers infer schema, they do NOT transform data
- Bookmarks control input, not output
- Spark partitions determine output file count
- Overwrite on S3 requires delete permissions
- Athena queries data; Glue transforms data

---

## Week 07 Status

- ETL design understood
- Incremental processing validated
- Failure-safe patterns learned
- One controlled Glue job run completed

Terraform automation is deferred until the design is stable.

---

## Next Steps

- Optionally Terraformize Glue jobs and crawlers
- Move to Week 08 (Athena / Redshift)
- Create exam flashcards from this week

Week 07 is COMPLETE.
