include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  configs_file_path = "../../../assets/${local.vars.locals.environment}/peering_config.json"
  configs_content = jsondecode(file(local.configs_file_path))
}

dependency "vpc" {
  config_path = "../../networking/vpc"
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/DSF%20Consent%20Service%20%28DCS%29/_git/terraform.code//infra/networking/peering_vpc?ref=${local.vars.locals.module_version.peering_vpc}"
}

inputs = {
  network_self_link = dependency.vpc.outputs.network_self_link
  peering_configs   = local.configs_content
}
