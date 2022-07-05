terraform {
  source = "${local.base_source_url}"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  env = local.environment_vars.locals.environment

  base_source_url = "../../../../modules//aws-log-group"
}

inputs = {
  name          = "log-group-example-${local.env}"
  retention = 7
}
