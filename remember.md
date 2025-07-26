AVRO - write - -> AWW  

Parquet = reed -> PR  
schema evolution => glue schema registry

• Amazon S3 Standard - General Purpose
• Amazon S3 Standard-Infrequent Access (IA)
• Amazon S3 One Zone-Infrequent Access
• Amazon S3 Glacier Instant Retrieval   | I
• Amazon S3 Glacier Flexible Retrieval  | F
• Amazon S3 Glacier Deep Archive        | De Ar
• Amazon S3 Intelligent Tiering         | InTier


## hadoop vs spark

| Feature    | Hadoop MapReduce             | Spark                                   |
| ---------- | ---------------------------- | --------------------------------------- |
| Processing | Disk-based                   | In-memory                               |
| Speed      | Slower                       | 10-100x faster                          |
| API        | Low-level                    | High-level (RDD, DataFrame, SQL, MLlib) |
| Use Cases  | Simple ETL, batch processing | ETL, ML, streaming                      |



##  Avro vs Parquet vs ORC

| Feature          | Avro                                    | Parquet                              | ORC              |
| ---------------- | --------------------------------------- | ------------------------------------ | ---------------- |
| **Format**       | Row-based                               | Columnar                             | Columnar         |
| **Compression**  | Yes (snappy, deflate)                   | Yes                                  | Yes              |
| **Best for**     | Write-heavy workloads, schema evolution | Read-heavy, analytics                | Hive integration |
| **Splittable**   | Yes                                     | Yes                                  | Yes              |
| **AWS Services** | Glue, Athena, EMR                       | Glue, Athena, EMR, Redshift Spectrum | EMR, Hive        |
