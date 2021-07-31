terraform {
  backend "s3" {
    bucket         = "sapientpants-terraform"
    region         = "eu-central-1"
    key            = "terraform.tfstate"
    dynamodb_table = "sapientpants-terraform"
    encrypt        = true
  }
}

resource "aws_dynamodb_table" "sapientpants_terraform" {
  name           = "sapientpants-terraform"
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

  # The namespace
  namespace = "sapientpants"

  # The environment associated with this account - typically organization, dev, staging or production
  environment = "organization"

  # Certificate ARN in AWS eu-central-1 - this can be created manually
  kms_key = "arn:aws:kms:eu-central-1:281277350703:key/b8b8ce8b-7127-4409-bd69-53d156fb29d5"
}

variable "pgp_key" {
  description = "A base-64 encoded PGP public key used to encrypt account AWS access keys"
}
