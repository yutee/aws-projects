variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}

variable "default_root_object" {
  description = "The default object that CloudFront serves when the root URL is requested."
  type        = string
  default     = "index.html"
}