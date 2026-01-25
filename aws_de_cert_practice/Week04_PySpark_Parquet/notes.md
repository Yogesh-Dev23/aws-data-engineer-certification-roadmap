# Week 04 — Spark Core (Local, Theory + In-Memory Practice)

## Goal
Build a strong **Spark mental model** (execution, transformations, partitions) so the *same logic* can later run on **EMR and AWS Glue** without changes.

> This week intentionally avoids Parquet writes on local Windows due to Hadoop filesystem limitations.  
> Parquet + partitioning are covered in **Week 5 (EMR)** and **Week 6 (Glue)** where they belong.

---

## What I Learned

### 1. What Apache Spark Is
- Spark is a **distributed data processing engine**
- Spark is **compute**, not storage
- It processes data in parallel using partitions

---

### 2. Core Spark Components
- **Driver**: Runs the PySpark script, builds execution plan (DAG)
- **Executor**: JVM process that executes tasks and holds data in memory
- **Task**: Smallest unit of work, operates on one partition

> Spark parallelism is controlled by the number of partitions and executors.

---

### 3. SparkSession
- Entry point to Spark
- Manages configs, DataFrames, and execution context

Local usage:
```python
SparkSession.builder.master("local[*]").getOrCreate()
On EMR / Glue:

No master specified

Cluster manager (YARN) allocates resources

4. DataFrames vs RDDs

DataFrames are optimized (Catalyst + Tungsten)

SQL-like, declarative, and required for AWS Glue

RDDs are low-level and rarely used in production

5. Lazy Evaluation

Transformations are lazy

Execution happens only when an action is called

Transformations

select, filter, withColumn, join, groupBy

Actions

show(), count(), collect(), write()

Spark builds a DAG and executes it only on actions.

6. DAG (Directed Acyclic Graph)

Logical execution plan of transformations

Optimized before execution

Viewable using:

df.explain()

7. Partitions

A partition is a chunk of data processed by one task

More partitions = more parallelism

Too many partitions = overhead (small files problem later)

Rule of thumb:

One partition per core during execution.

8. In-Memory Processing

Spark keeps intermediate data in memory

Falls back to disk only when required

Much faster than disk-based MapReduce

What I Practiced Locally

Creating SparkSession

Creating DataFrames (CSV and in-memory)

Transformations and aggregations

Execution plans (explain)

Actions (show, count)

What I Deferred (By Design)

Writing Parquet files locally on Windows

Hadoop filesystem configuration

Reason:

Not production-representative

Causes unnecessary setup issues

Cloud-managed Spark (EMR / Glue) is the industry standard

Key Takeaways (Exam + Interview Ready)

Spark is compute, not storage

Execution is lazy and DAG-based

Parallelism depends on partitions

DataFrames are preferred over RDDs

Spark code is portable across environments

Next Steps

➡️ Week 5 — Spark on EMR

Learn Hadoop concepts (YARN, HDFS)

Run Spark on EMR

Write partitioned Parquet to S3

Use Terraform for cluster lifecycle

Terminate cluster to avoid costs

Week 4 Status

✔ Spark execution model
✔ Driver / Executor / Task
✔ Lazy evaluation & DAG
✔ Partition fundamentals
✔ Local Spark logic (in-memory)