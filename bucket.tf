resource "aws_s3_bucket" "my-s3-day8-1" {
  bucket = "my-s3-day8-1"
   force_destroy = true
}


resource  "aws_s3_bucket_public_access_block" "my-s3-day8-1" {
    bucket = "my-s3-day8-1"
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}