# Week 06 – AWS Glue (DEA-C01 Exam Notes)

## Goal of Week 6
Understand **AWS Glue fundamentals**: schema discovery, metadata management, serverless Spark ETL, and when to use Glue vs EMR.  
Focus is **conceptual + behavioral**, not Terraform.

---

## What is AWS Glue?
- Serverless **data integration (ETL)** service
- Built on **managed Apache Spark**
- No cluster provisioning or management
- Pay per **DPU-hour**

Glue is best for:
- Batch ETL
- Schema discovery
- Incremental processing
- Low operational overhead pipelines

---

## Core Glue Components

### 1. Glue Crawler
- Scans data sources (S3, JDBC, DynamoDB)
- Automatically infers:
  - Column names
  - Data types
  - Partitions
- Creates or updates tables in Glue Data Catalog

**Exam tip:**  
Use crawlers when schemas are **unknown or evolving**.

---

### 2. Glue Data Catalog
- Central metadata repository (Hive-compatible)
- Stores:
  - Databases
  - Tables
  - Schemas
  - Partition metadata
- Used by:
  - Glue
  - Athena
  - EMR
  - Redshift Spectrum

⚠️ **Important distinction**
- Catalog partitions ≠ Spark execution partitions
- Catalog partitions are metadata-level only

---

### 3. Glue Jobs
- Serverless Spark jobs
- Use **GlueContext** (Glue-aware Spark wrapper)
- Can read data via:
  - S3 paths
  - Glue Data Catalog tables

Charged by:
- DPU-hours
- Worker type (e.g., G.1X)

---

## GlueContext
- Wrapper on top of SparkContext
- Integrates Spark with Glue services
- Enables:
  - Glue Catalog reads
  - DynamicFrames
  - Job bookmarks
  - Glue logging

Without GlueContext → you are just using Spark.

---

## DynamicFrame vs DataFrame

### DynamicFrame
- Glue-specific abstraction
- Schema-flexible
- Handles schema evolution
- Required for bookmarks
- Slightly slower

### DataFrame
- Native Spark API
- Faster
- Rich transformations

**Best practice:**


Read as DynamicFrame → Convert to DataFrame → Transform


---

## Glue Job Arguments
- Runtime parameters passed as:

--KEY value

- Read using `getResolvedOptions`
- Used for:
- Input paths
- Output paths
- Environment separation

Avoid hardcoding S3 paths.

**Exam tip:**  
Reusable Glue jobs use **job arguments**, not hardcoded values.

---

## Job Bookmarks (Incremental Processing)

### What are bookmarks?
Glue’s mechanism to remember **previously processed data**.

### What Glue tracks
- S3 sources → file paths & timestamps
- Catalog tables → partition values
- JDBC → incremental columns

### Bookmark modes
- **Enable** → incremental processing
- **Disable** → full reprocessing
- **Pause** → read bookmark but don’t update

⚠️ Bookmarks work only when:
- Using GlueContext
- Using DynamicFrame sources
- Reading from Catalog or Glue-managed sources

❌ Bookmarks do NOT work with:
- `spark.read.csv()`

---

## Spark Output Behavior in Glue
- Spark writes **one file per execution partition**
- Multiple `part-*.parquet` files are normal
- Number of files ≠ number of rows
- Catalog partitions do NOT control output file count

**Exam rule:**
Spark parallelism determines output file count.

---

## Common IAM Pitfalls with Glue
- AWS managed Glue role does NOT grant access to custom S3 buckets
- Glue job role needs explicit permissions:
- `s3:ListBucket`
- `s3:GetObject`
- `s3:PutObject`
- `s3:DeleteObject` (required for overwrite)

Spark overwrite on S3 deletes:
- Data files
- `_SUCCESS`
- S3 folder marker objects (e.g. `path_$folder$`)

---

## Glue vs EMR (Exam Comparison)

### Choose AWS Glue when:
- Serverless ETL
- Schema discovery
- Incremental processing
- Glue Data Catalog integration
- Low ops overhead

### Choose EMR when:
- Full Spark/Hadoop control
- Custom tuning
- Long-running clusters
- Advanced big data workloads

**Exam shortcut:**
- ETL + serverless + metadata → **Glue**
- Control + tuning + cluster → **EMR**

---

## What Week 6 Did NOT Cover (Intentionally)
- Terraform for Glue
- Performance tuning
- Advanced Spark configs
- ACID table formats (Iceberg/Delta/Hudi)

These come in later weeks once Glue concepts are solid.

---

## Key Exam Takeaways (Memorize)
- Glue is serverless Spark ETL
- Crawlers infer schema
- Data Catalog is the metadata source of truth
- Job bookmarks enable incremental processing
- DynamicFrame enables schema evolution
- Spark partitions determine output files
- Glue vs EMR depends on control vs convenience

---

## Status
✅ Week 6 complete
