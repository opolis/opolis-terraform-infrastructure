include "root" {
  path = "${dirname(get_path_to_repo_root())}/main.hcl"
  expose = true
}

include "envcommon" {
  path = "${dirname(get_path_to_repo_root())}/_envcommon/aws-log-group.hcl"
  expose = true
}

locals {
  env = "${include.root.locals.environment}"
  org = "${include.root.locals.organization}"
}

inputs = {
  name = "appname-${local.org}-${local.env}"
}
