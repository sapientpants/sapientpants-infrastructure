data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.namespace}-${var.environment}-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket        = "${var.namespace}-${var.environment}-cloudtrail"
  force_destroy = true


}

// resource "aws_s3_bucket_policy" "cloudtrail_bucket" {
//   bucket = aws_s3_bucket.cloudtrail_bucket.id
//   policy = <<POLICY
// {
//     "Version": "2012-10-17",
//     "Statement": [
//         {
//             "Sid": "AWSCloudTrailAclCheck",
//             "Effect": "Allow",
//             "Principal": {
//               "Service": "cloudtrail.amazonaws.com"
//             },
//             "Action": "s3:GetBucketAcl",
//             "Resource": "arn:aws:s3:::${var.namespace}-${var.environment}-cloudtrail"
//         },
//         {
//             "Sid": "AWSCloudTrailWrite",
//             "Effect": "Allow",
//             "Principal": {
//               "Service": "cloudtrail.amazonaws.com"
//             },
//             "Action": "s3:PutObject",
//             "Resource": "arn:aws:s3:::${var.namespace}-${var.environment}-cloudtrail/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
//             "Condition": {
//                 "StringEquals": {
//                     "s3:x-amz-acl": "bucket-owner-full-control"
//                 }
//             }
//         }
//     ]
// }
// POLICY
// }

resource "aws_s3_bucket_acl" "cloudtrail_bucket" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_bucket" {
  bucket = aws_s3_bucket.cloudtrail_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key
      sse_algorithm     = "aws:kms"
    }
  }
}
