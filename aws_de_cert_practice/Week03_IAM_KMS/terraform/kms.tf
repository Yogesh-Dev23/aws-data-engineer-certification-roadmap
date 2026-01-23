resource "aws_kms_key" "this" {
  description             = "Week03 demo CMK for data encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = file("../policies/kms_key_policy.json")

  tags = {
    Project = "AWS Data Engineer Roadmap"
    Week    = "03"a
  }
}

resource "aws_kms_alias" "this" {
  name          = "alias/week03-data-key"
  target_key_id = aws_kms_key.this.key_id
}
