include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/Fiducia%20System/_git/terraform.code//infra/artifact?ref=${local.vars.locals.module_version.artifact}"
}

inputs = {
  project_name          = local.vars.locals.project_name
  location              = local.vars.locals.region
  repo_format           = "DOCKER"
  environment           = local.vars.locals.environment
  repo_names            = ["backend", "portal", "apigateway"]
}
