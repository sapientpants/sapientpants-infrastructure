terraform {
  backend "s3" {
    bucket         = "sapientpants-sandbox-terraform"
    region         = "eu-central-1"
    key            = "terraform.tfstate"
    // dynamodb_table = "sapientpants-sandbox-terraform"
    encrypt        = true
  }
}

resource "aws_dynamodb_table" "sapientpants_sandbox_terraform" {
  name           = "sapientpants-sandbox-terraform"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }
}

provider "aws" {
  region = local.region
}

locals {
  # The default region for this account
  region = "eu-central-1"

  # The organization AWS account ID
  organization_account_id = "281277350703"

  # The sandbox AWS account ID
  sandbox_account_id = "706917661981"

  # The namespace
  namespace = "sapientpants"

  # The environment associated with this account - typically organization, dev, staging or production
  environment = "sandbox"

  # Trusted IP address ranges
  trusted_cidr_blocks = []

  # Certificate ARN in AWS eu-central-1 - this can be created manually
  kms_key = "arn:aws:kms:eu-central-1:706917661981:key/767fb4b0-d5da-4bef-87ef-bbf9f5a2094d"
}

variable "pgp_key" {
  description = "A base-64 encoded PGP public key used to encrypt account AWS access keys"
}
