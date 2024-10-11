include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  # Define the relative path to the firewall-rules.json file
  firewall_rules_file_path = "../../../assets/${local.vars.locals.environment}/firewall-rules.json"

  # Read the firewall rules content from the JSON file
  firewall_rules_content = jsondecode(file(local.firewall_rules_file_path))

  # Filter allow and deny rules
  allow_firewall_rules = [for rule in local.firewall_rules_content : rule if rule.rule == "allow"]
  deny_firewall_rules  = [for rule in local.firewall_rules_content : rule if rule.rule == "deny"]
  icmp_firewall_rules = [for rule in local.firewall_rules_content : rule if rule.rule == "allow" && rule.protocol == "icmp"]
}

dependency "vpc" {
  config_path = "../../networking/vpc"
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/DSF%20Consent%20Service%20%28DCS%29/_git/terraform.code//infra/networking/firewall_rules?ref=${local.vars.locals.module_version.firewall_rules}"
}

inputs = {
  project_id            = local.vars.locals.gcp_project_id
  project_name          = local.vars.locals.project_name
  region                = local.vars.locals.region
  environment           = local.vars.locals.environment
  allow_firewall_rules  = local.allow_firewall_rules
  deny_firewall_rules   = local.deny_firewall_rules
  network_self_link     = dependency.vpc.outputs.network_self_link
}
