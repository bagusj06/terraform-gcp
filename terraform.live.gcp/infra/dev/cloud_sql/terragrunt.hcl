include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  # Define the relative path to the JSON file
  configs_file_path = "../../assets/${local.vars.locals.environment}/db_auth_network.json"

  # Read the firewall rules content from the JSON file
  configs_content = jsondecode(file(local.configs_file_path))
}

dependency "vpc" {
  config_path = "../networking/vpc"
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/Fiducia%20System/_git/terraform.code//infra/cloud_sql?ref=${local.vars.locals.module_version.cloud_sql}"
}

inputs = {
  project_id            = local.vars.locals.gcp_project_id
  project_name          = local.vars.locals.project_name
  environment           = local.vars.locals.environment
  region                = local.vars.locals.region
  zone                  = local.vars.locals.zone
  database_version      = local.vars.locals.cloud_sql.database_version
  instance_tier         = local.vars.locals.cloud_sql.instance_tier
  network_id            = dependency.vpc.outputs.network_id
  auth_network          = local.configs_content
}
