locals {
  parsed_path   = regex("(?P<infra_type>.*?)/(?P<infra_env>.*?)/(?P<region>.*?)/(?P<module>.*)", path_relative_to_include())
  infra_type     = local.parsed_path.infra_type
  infra_env     = local.parsed_path.infra_env
  region        = local.parsed_path.region
  module        = local.parsed_path.module

  account_vars = read_terragrunt_config("${path_relative_from_include()}/${local.infra_type}/${local.infra_env}/account.hcl")
  environment_vars = read_terragrunt_config("${path_relative_from_include()}/${local.infra_type}/${local.infra_env}/env.hcl")
  region_vars = read_terragrunt_config("${path_relative_from_include()}/${local.infra_type}/${local.infra_env}/${local.region}/region.hcl")

  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
  environment = local.environment_vars.locals.environment
  organization = "org"
  #<orgname><key><region><env>
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  allowed_account_ids = ["${local.account_id}"]
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${get_env("TG_BUCKET_PREFIX", "orgname")}-terraform-state-${local.infra_type}-${local.aws_region}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)