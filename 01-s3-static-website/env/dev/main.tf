resource "random_integer" "number" {
  min = 1000
  max = 9999
}

module "s3_static_website" {
  source              = "../../modules/s3-static-website"
  bucket_name         = "static-website-bucket-${random_integer.number.id}"
  default_root_object = var.default_root_object
}