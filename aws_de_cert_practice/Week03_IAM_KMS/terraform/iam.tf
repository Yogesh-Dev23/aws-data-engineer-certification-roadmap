resource "aws_iam_role" "kms_user" {
  name = "week03-kms-user"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root" }
      Action    = "sts:AssumeRole"
    }]
  })
}



resource "aws_iam_role_policy" "kms_user_policy" {
  role = aws_iam_role.kms_user.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ]
      Resource = aws_kms_key.this.arn
    }]
  })
}

