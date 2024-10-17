
# create an s3 bucket with public access and a static website configuration
resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "static_website_ownership" {
  bucket = aws_s3_bucket.static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static_website_public_access" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# AWS S3 bucket ACL resource
resource "aws_s3_bucket_acl" "state_website_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static_website_ownership,
    aws_s3_bucket_public_access_block.static_website_public_access,
  ]

  bucket = aws_s3_bucket.static_website.id
  acl    = "public-read"
}


resource "aws_s3_bucket_policy" "static_website_bucket_policy" {
  bucket =  aws_s3_bucket.static_website.id

  # Policy JSON for allowing public read access
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource": "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket =    aws_s3_bucket.static_website.id  # ID of the S3 bucket

  # Configuration for the index document
  index_document {
      suffix = "index.html"
    }

   # Configuration for the error document
   error_document {
      key = "error.html"
    } 
}


module "template_files" {
    source = "hashicorp/dir/template"
    base_dir = "${path.module}/static_website_files"
}

# https://registry.terraform.io/modules/hashicorp/dir/template/latest #link to template files module

# AWS S3 object resource for hosting bucket files
resource "aws_s3_object" "bucket_files" {
  bucket =  aws_s3_bucket.static_website.id

  for_each     = module.template_files.files
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  # ETag of the S3 object
  etag = each.value.digests.md5
}

resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name = aws_s3_bucket.static_website.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.static_website.id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for S3 website"
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.static_website.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
        }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Access Identity for S3 bucket"
}