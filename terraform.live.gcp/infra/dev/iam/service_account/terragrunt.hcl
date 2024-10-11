include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  configs_file_path = "../../../assets/${local.vars.locals.environment}/service_account_config.json"
  configs_content = jsondecode(file(local.configs_file_path))
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/Fiducia%20System/_git/terraform.code//infra/iam/service_account?ref=${local.vars.locals.module_version.service_account}"
}

inputs = {
  project_id          = local.vars.locals.gcp_project_id
  service_accounts    = local.configs_content
}
