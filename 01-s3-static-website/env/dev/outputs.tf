output "s3_static_website" {
  description = "The name of the S3 bucket hosting the website"
  value       = module.s3_static_website.bucket_name
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.s3_static_website.cloudfront_domain_name
}