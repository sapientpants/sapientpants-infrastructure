module "cloudtrail" {
  source      = "../../modules/cloudtrail"
  namespace   = local.namespace
  environment = local.environment
  kms_key     = local.kms_key
}
