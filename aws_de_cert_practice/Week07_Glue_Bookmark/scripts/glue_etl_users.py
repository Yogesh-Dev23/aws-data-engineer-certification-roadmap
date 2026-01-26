import sys
from pyspark.context import SparkContext
from pyspark.sql.functions import col
from awsglue.context import GlueContext
from awsglue.utils import getResolvedOptions

# -------------------------------------------------
# Read job arguments
# -------------------------------------------------
args = getResolvedOptions(
    sys.argv,
    [
        "JOB_NAME",
        "INPUT_DB",
        "INPUT_TABLE",
        "OUTPUT_PATH"
    ]
)

# -------------------------------------------------
# Initialize Glue & Spark
# -------------------------------------------------
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

print("Starting Glue Job:", args["JOB_NAME"])

# -------------------------------------------------
# Read from Glue Data Catalog (BOOKMARK ENABLED)
# -------------------------------------------------
raw_dyf = glueContext.create_dynamic_frame.from_catalog(
    database=args["INPUT_DB"],
    table_name=args["INPUT_TABLE"]
)

print("Raw DynamicFrame schema:")
raw_dyf.printSchema()

# -------------------------------------------------
# Convert DynamicFrame → Spark DataFrame
# -------------------------------------------------
raw_df = raw_dyf.toDF()

# -------------------------------------------------
# Transformations (ETL logic)
# -------------------------------------------------

# Cast amount to integer
clean_df = raw_df.withColumn(
    "amount",
    col("amount").cast("int")
)

# Aggregate by country
result_df = (
    clean_df
    .groupBy("country")
    .sum("amount")
    .withColumnRenamed("sum(amount)", "total_amount")
)

print("Result row count:", result_df.count())
result_df.printSchema()

# -------------------------------------------------
# Write curated data (SAFE pattern)
# -------------------------------------------------
(
    result_df
    .write
    .mode("append")                # SAFE with retries
    .partitionBy("country")        # Analytics-friendly
    .parquet(args["OUTPUT_PATH"])
)

print("ETL completed successfully")
