include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/DSF%20Consent%20Service%20%28DCS%29/_git/terraform.code//infra/networking/vpc?ref=${local.vars.locals.module_version.vpc}"
}

inputs = {
  project_id    = local.vars.locals.gcp_project_id
  project_name  = local.vars.locals.project_name
  region        = local.vars.locals.region
  environment   = local.vars.locals.environment
  ip_cidr_range = local.vars.locals.vpc.ip_cidr_range
}