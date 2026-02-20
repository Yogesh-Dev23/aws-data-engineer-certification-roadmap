from pyspark.sql import SparkSession
from pyspark.sql.functions import col
import sys
import traceback

print("=== Spark job started ===")

try:
    print("Creating SparkSession...")
    spark = SparkSession.builder.appName("CSV to Parquet").getOrCreate()
    print("SparkSession created")

    input_path = "s3://yogesh-terraform-s3-mini-project-001/raw/input.csv"
    output_path = "s3://yogesh-terraform-s3-mini-project-001/processed/"

    print(f"Reading CSV from: {input_path}")
    df = (
        spark.read
             .option("header", "true")
             .csv(input_path)
    )

    print("CSV read completed")
    print("Schema after read:")
    df.printSchema()

    print("Counting input rows (forces action)...")
    input_count = df.count()
    print(f"Input row count: {input_count}")

    print("Casting column 'amount' to int")
    df = df.withColumn("amount", col("amount").cast("int"))

    print("Schema after casting:")
    df.printSchema()

    print("Running aggregation: groupBy(country).sum(amount)")
    result = (
        df.groupBy("country")
          .sum("amount")
          .withColumnRenamed("sum(amount)", "total_amount")
    )

    print("Aggregation completed")
    print("Result schema:")
    result.printSchema()

    print("Counting result rows...")
    result_count = result.count()
    print(f"Result row count: {result_count}")

    print(f"Writing Parquet output to: {output_path}")
    result.write.mode("overwrite").parquet(output_path)

    print("Parquet write completed successfully")

    spark.stop()
    print("SparkSession stopped")
    print("=== Spark job completed SUCCESSFULLY ===")

except Exception as e:
    print("!!! Spark job FAILED !!!", file=sys.stderr)
    print("Exception message:", str(e), file=sys.stderr)
    print("Full traceback:", file=sys.stderr)
    traceback.print_exc(file=sys.stderr)

    try:
        spark.stop()
    except Exception:
        pass

    sys.exit(1)
