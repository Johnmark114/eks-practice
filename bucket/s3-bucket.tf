resource "aws_s3_bucket" "state-lock" {
  bucket = "innovatemart-state-lock-812835203419"

  tags = {
    Name        = "My bucket"
    Environment = "production"
  }
}
resource "aws_s3_bucket_versioning" "versioning_state-lock" {
  bucket = aws_s3_bucket.state-lock.id
  versioning_configuration {
    status = "Enabled"
  }
}