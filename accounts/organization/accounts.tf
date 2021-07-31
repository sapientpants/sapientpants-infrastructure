/*
Application user accounts
*/

# CI runners user account - by default can only push & pull from ECR
// module "ci_user" {
//   source  = "../../modules/iam/user_ci"
//   pgp_key = var.pgp_key
// }

# Terraform user account for applying account changes
module "terraform_user" {
  source  = "../../modules/iam/user_terraform"
  pgp_key = var.pgp_key
}

/*
Groups
- Administrators have full access to all accounts
- Developers have restricted access to the organization account and administrator access
*/

module "administrator_group" {
  source = "../../modules/iam/group_administrator"
}

/*
Administrator user accounts
*/

module "marc" {
  source = "../../modules/iam/user"
  name   = "marc"

  groups = [
    module.administrator_group.name,
  ]
}

/*
Developer user accounts
*/

# Example developer user account
// module "developer_user" {
//   source = "../../modules/iam/user"
//   name   = "developer"

//   groups = [
//     module.developer_group.name,
//   ]
// }
