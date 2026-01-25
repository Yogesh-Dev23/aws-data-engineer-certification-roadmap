resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Project   = "S3-Mini-Project"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_access_point" "this" {
  name   = "yogesh-s3-mini-ap"
  bucket = aws_s3_bucket.this.id

}

data "aws_caller_identity" "current" {}


resource "aws_s3control_access_point_policy" "this" {
  access_point_arn = aws_s3_access_point.this.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_caller_identity.current.arn
        }
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Resource = [
          aws_s3_access_point.this.arn,
          "${aws_s3_access_point.this.arn}/object/*"
        ]
        Condition = {
          StringEquals = {
            "aws:SourceVpc" = aws_vpc.this.id
          }
        }
      }
    ]
  })
}


resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mini-vpc"
  }
}


resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet"
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private.id
  ]
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}


