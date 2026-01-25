from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum, count, year, to_date

spark = SparkSession.builder \
    .appName("spark_in_memory_learning") \
    .master("local[*]") \
    .getOrCreate()

data = [
    (1, "Alice", 100.0, "2024-01-10"),
    (2, "Bob", 200.0, "2024-01-15"),
    (3, "Alice", 150.0, "2024-02-10"),
]

columns = ["id", "name", "amount", "event_date"]

df = spark.createDataFrame(data, columns)

df = df.withColumn("event_date", to_date("event_date"))
df = df.withColumn("year", year("event_date"))

df.show()
df.groupBy("name", "year").agg(
    sum("amount").alias("total_amount"),
    count("*").alias("txn_count")
).show()

df.explain()

spark.stop()
