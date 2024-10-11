include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  # Define the relative path to the peering_config.json file
  configs_file_path = "../../../assets/${local.vars.locals.environment}/service_account_config.json"

  # Read and parse the entire peering configurations from the JSON file
  configs_content = jsondecode(file(local.configs_file_path))
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/DSF%20Consent%20Service%20%28DCS%29/_git/terraform.code//infra/iam/service_account?ref=${local.vars.locals.module_version.service_account}"
}

inputs = {
  project_id          = local.vars.locals.gcp_project_id
  service_accounts    = local.configs_content
}
