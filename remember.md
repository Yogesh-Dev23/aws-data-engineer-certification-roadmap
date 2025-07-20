AVRO - write - -> AWW  

Parquet = reed -> PR



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
