from pyspark.sql import SparkSession
import pyspark
from pyspark import SparkContext

spark = (
    SparkSession.builder
    .appName("Week04-CSV-to-Parquet")
    .master("local[1]")
    .config("spark.hadoop.io.native.lib.available", "false")
    .config("spark.hadoop.fs.file.impl", "org.apache.hadoop.fs.LocalFileSystem")
    .getOrCreate()
)


df = spark.read.option("header", "true").option("inferSchema", "true").csv("../data/sample.csv")

df.printSchema()
df.show()

(
    df.write
    .mode("overwrite")
    .partitionBy("year", "month")
    .parquet("file:///C:/tmp/parquet_output")



)

spark.stop()
