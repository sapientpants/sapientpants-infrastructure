resource "aws_s3_account_public_access_block" "s3_account_public_access_block" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// files bucket

// resource "aws_s3_bucket" "files_bucket" {
//   bucket        = "${local.namespace}-${local.stage}-files"
//   acl           = "private"
//   force_destroy = false

//   logging {
//     target_bucket = aws_s3_bucket.files_logs_bucket.id
//     target_prefix = "log/"
//   }

//   versioning {
//     enabled = false
//   }

//   server_side_encryption_configuration {
//     rule {
//       apply_server_side_encryption_by_default {
//         kms_master_key_id = local.kms_key
//         sse_algorithm     = "aws:kms"
//       }
//     }
//   }
// }

// resource "aws_s3_bucket" "files_logs_bucket" {
//   bucket        = "${local.namespace}-${local.stage}-files-logs"
//   acl           = "log-delivery-write"
//   force_destroy = false

//   versioning {
//     enabled = false
//   }

//   server_side_encryption_configuration {
//     rule {
//       apply_server_side_encryption_by_default {
//         kms_master_key_id = local.kms_key
//         sse_algorithm     = "aws:kms"
//       }
//     }
//   }
// }