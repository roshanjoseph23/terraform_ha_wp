resource "aws_cloudfront_origin_access_identity" "s3identity" {
  comment = "access-identity-s3"
}

resource "aws_cloudfront_distribution" "s3cdn" {
  origin {
    domain_name = var.aws_s3_bucket_ha_s3_bucket_domain_name
    origin_id   = var.s3origin
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3identity.cloudfront_access_identity_path
    }

  }
  enabled = true
  logging_config {
    include_cookies = false
    bucket          = "<bucket_name>.s3.amazonaws.com"
    prefix          = "cdnlogs"
  }

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3origin
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  price_class = "PriceClass_All"
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = {
    Environment = "Test"
  }
}
