resource "aws_glue_catalog_database" "raw_db" {
  name = "week07_raw_db"
}

resource "aws_glue_catalog_database" "curated_db" {
  name = "week07_curated_db"
}
