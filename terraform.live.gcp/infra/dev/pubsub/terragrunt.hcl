include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/DSF%20Consent%20Service%20%28DCS%29/_git/terraform.code//infra/pubsub?ref=${local.vars.locals.module_version.pubsub}"
}

inputs = {
  project_id            = local.vars.locals.gcp_project_id
  project_name          = local.vars.locals.project_name
  environment           = local.vars.locals.environment
  region                = local.vars.locals.region
}
