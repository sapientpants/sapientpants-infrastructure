output "terraform_user_access_key_id" {
  value = module.terraform_user.aws_access_key_id
}

output "terraform_user_secret_access_key" {
  value = module.terraform_user.aws_secret_access_key
}

