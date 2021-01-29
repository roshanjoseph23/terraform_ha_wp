resource "aws_s3_bucket" "ha_s3" {
  bucket        = "roshanjoseph.ml"
  acl           = "public-read"
  force_destroy = true
  policy        = file("./modules/s3/policy.json")
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "roshanjoseph.ml"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "uploads_folder" {
  bucket       = aws_s3_bucket.ha_s3.id
  acl          = "public-read"
  key          = "uploads/"
  content_type = "application/x-directory"
}


