# AWS Data Engineer Cheat Sheet: Properties & Types of Data

> Quickly map concepts to AWS services during pipeline design, interview prep, or exam revision.

---

## 1️⃣ Types of Data

| Type                | Description                 | AWS Services                                                        |
| ------------------- | --------------------------- | ------------------------------------------------------------------- |
| **Structured**      | Tables, CSV, SQL            | RDS, Redshift, Glue Catalog, Athena                                 |
| **Semi-Structured** | JSON, Avro, XML, Parquet    | S3, Glue ETL, Athena, Redshift Spectrum                             |
| **Unstructured**    | Images, videos, logs, audio | S3, Rekognition (images), Transcribe (audio), Macie (logs with PII) |
| **Streaming**       | Real-time event data        | Kinesis Data Streams/Firehose, Lambda, MSK                          |
| **Batch**           | Periodic, scheduled loads   | Glue ETL, EMR, Batch, Step Functions                                |

---

## 2️⃣ Properties of Data & AWS Services

| Property             | Description               | AWS Services                                  |
| -------------------- | ------------------------- | --------------------------------------------- |
| **Volume**           | Size of data              | S3 (scalable), Glacier (archival), Redshift   |
| **Velocity**         | Speed of ingestion        | Kinesis, Firehose, Lambda                     |
| **Variety**          | Multiple data types       | Glue, S3, Redshift Spectrum                   |
| **Veracity**         | Data quality, correctness | Glue DataBrew, Lambda validation, EMR scripts |
| **Value**            | Business usefulness       | Athena, Redshift, QuickSight                  |
| **Lineage**          | Track data flow           | Glue Catalog, Lake Formation                  |
| **Schema Evolution** | Handling schema changes   | Glue ETL, Parquet/Avro                        |
| **Privacy/Security** | Encryption, PII detection | KMS, IAM, Macie, Lake Formation               |

---

## 3️⃣ Storage & Compute Services

| Concept               | AWS Services            |
| --------------------- | ----------------------- |
| Object Storage        | S3, Glacier             |
| Block Storage         | EBS                     |
| File Storage          | EFS                     |
| Data Warehouse        | Redshift                |
| ETL & Data Prep       | Glue ETL, Glue DataBrew |
| Big Data Processing   | EMR, Spark on EMR       |
| Serverless Compute    | Lambda                  |
| Containerized Compute | ECS, EKS                |

---

## 4️⃣ Data Movement & Ingestion

| Scenario               | AWS Services                        |
| ---------------------- | ----------------------------------- |
| Real-Time Streaming    | Kinesis Data Streams, Firehose, MSK |
| Batch Ingestion        | Glue ETL, EMR                       |
| Database Migration     | DMS                                 |
| Transfer Service       | AWS Transfer Family                 |
| Event-Based Triggering | EventBridge, SNS, SQS, Lambda       |

---

## 5️⃣ Data Security & Compliance

| Requirement           | AWS Services         |
| --------------------- | -------------------- |
| Encryption at Rest    | KMS, SSE-S3, SSE-KMS |
| Encryption in Transit | TLS/SSL              |
| Access Control        | IAM, Lake Formation  |
| PII Detection         | Macie                |
| Key Management        | KMS                  |

---

## 6️⃣ Querying & Analysis

| Use Case               | AWS Services              |
| ---------------------- | ------------------------- |
| Ad-hoc SQL Queries     | Athena                    |
| Analytics & Reporting  | QuickSight                |
| SQL on Structured Data | Redshift                  |
| SQL on S3 Data         | Redshift Spectrum, Athena |

---

## 7️⃣ Orchestration & Monitoring

| Need                   | AWS Services                   |
| ---------------------- | ------------------------------ |
| Workflow Orchestration | Step Functions, Airflow (MWAA) |
| Monitoring & Logging   | CloudWatch, CloudTrail         |
| Alerting               | SNS, CloudWatch Alarms         |

---

## ✅ Usage:

✅ **During labs:** Check which services align with the property/type of data you handle.
✅ **During exam prep:** Match scenario-based questions with the correct AWS service.
✅ **During pipeline design:** Use the property/type as your design anchor, map to AWS, and note constraints.

---

> **Keep this file in each relevant `weekXX_topic/` folder or in your `cheat_sheets/` folder for instant reference during your AWS Data Engineer certification prep.**
