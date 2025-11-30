# Parquet Cheat Sheet: AWS Data Engineer

## 🚀 What is Parquet?

Apache Parquet is a **columnar storage format** designed for **efficient storage and retrieval**, optimized for big data workloads and analytics.

* Columnar → reads only required columns.
* Highly compressible.
* Splittable → supports parallelism in Spark, Glue, EMR.
* Supports schema evolution.

---

## 🪐 Why Parquet?

✅ Efficient analytics, OLAP workloads.
✅ Reduces I/O, storage, and query costs.
✅ Supported by Spark, Hive, AWS Glue, Athena, Redshift Spectrum.
✅ Best suited for **read-heavy workloads**.

---

## 🔍 Parquet File Structure

* **Columnar** (columns organized together).
* Contains header, row groups (column chunks), and footer with metadata/schema.
* Footer enables fast schema discovery and data skipping.

---

## ⚙️ Schema Evolution

✅ Add columns (appended).
✅ Remove columns (remain in data but hidden in queries).
✅ Careful type evolution (upcasting easier).

---

## 🛠️ Using Parquet on AWS

### Storage:

* Store Parquet files in S3.
* Enable Athena/Redshift Spectrum querying.
* Use partitioning (year, month, day) to improve query performance.

### ETL:

* Use AWS Glue ETL to convert CSV/Avro/JSON to Parquet.
* Write transformed data to S3 in Parquet for efficient storage.

### Analytics:

* Use Athena or Redshift Spectrum for SQL-based analysis on Parquet files.

---

## 🐍 PySpark & Parquet

```python
# Reading Parquet
spark.read.parquet("s3://your-bucket/path/")

# Writing Parquet
spark.write.parquet("s3://your-bucket/output/")

# Writing with partitioning
spark.write.partitionBy("year", "month").parquet("s3://your-bucket/output/")
```

---

## 🔹 Parquet vs Avro vs ORC

| Feature      | Parquet                              | Avro                          | ORC              |
| ------------ | ------------------------------------ | ----------------------------- | ---------------- |
| Format       | Columnar                             | Row-based                     | Columnar         |
| Compression  | Excellent                            | Good                          | Excellent        |
| Best for     | Analytics, OLAP                      | Write-heavy, schema evolution | Hive integration |
| Splittable   | Yes                                  | Yes                           | Yes              |
| AWS Services | Glue, Athena, EMR, Redshift Spectrum | Glue, Athena, EMR             | EMR, Hive        |

---

## 🛡️ Compression

✅ Supports Snappy (default), Gzip, LZO.
✅ Columnar compression improves efficiency.

---

## 🧪 CLI & Athena Example

**Upload Parquet to S3:**

```bash
aws s3 cp local_file.parquet s3://your-bucket/path/
```

**Create Athena Table:**

```sql
CREATE EXTERNAL TABLE your_table (
  name string,
  age int,
  email string
)
STORED AS PARQUET
LOCATION 's3://your-bucket/path/';
```

---

## 🚩 Summary

| Concept          | Details                                  |
| ---------------- | ---------------------------------------- |
| Format           | Columnar, schema-based                   |
| Compression      | Snappy, Gzip, LZO                        |
| Splittable       | Yes                                      |
| Schema Evolution | Supported                                |
| Best For         | Read-heavy, OLAP workloads               |
| AWS Services     | Glue, Athena, S3, EMR, Redshift Spectrum |
| Tools            | PySpark, Spark CLI, Glue ETL             |

---

> Save this in your `cheat_sheets/` or `week04_pyspark_local/` folder for fast reference during your AWS Data Engineer preparation.
