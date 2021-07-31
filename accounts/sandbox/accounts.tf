# Cross account roles
module "cross_account_administrator_role" {
  source = "../../modules/iam/role_cross_account_administrator"

  identifiers = [
    "arn:aws:iam::${local.organization_account_id}:root",
  ]
}

module "cross_account_developer_role" {
  source = "../../modules/iam/role_cross_account_developer"
  identifiers = [
    "arn:aws:iam::${local.organization_account_id}:root",
  ]
}

# Terraform user account for applying account changes
module "terraform_user" {
  source  = "../../modules/iam/user_terraform"
  pgp_key = var.pgp_key
}

