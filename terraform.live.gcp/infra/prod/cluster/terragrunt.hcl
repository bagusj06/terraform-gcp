include "root" {
  path = find_in_parent_folders()
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  configs_file_path = "../../assets/${local.vars.locals.environment}/cluster_auth_network.json"
  configs_content = jsondecode(file(local.configs_file_path))
}

dependency "vpc" {
  config_path = "../networking/vpc"
}

terraform {
  source = "git::https://${local.vars.locals.git_repo_token}@dev.azure.com/ddcdipostar/DSF%20Consent%20Service%20%28DCS%29/_git/terraform.code//infra/cluster?ref=${local.vars.locals.module_version.cluster}"
}

inputs = {
  project_id              = local.vars.locals.gcp_project_id
  project_name            = local.vars.locals.project_name
  region                  = local.vars.locals.cluster.zone
  environment             = local.vars.locals.environment
  vpc_name                = dependency.vpc.outputs.vpc_name
  subnet_name             = dependency.vpc.outputs.subnet_name
  min_node_count          = local.vars.locals.cluster.min_node_count
  max_node_count          = local.vars.locals.cluster.max_node_count
  machine_type            = local.vars.locals.cluster.machine_type
  disk_size_gb            = local.vars.locals.cluster.disk_size_gb
  disk_type               = local.vars.locals.cluster.disk_type
  deletion_protection     = local.vars.locals.cluster.deletion_protection
  master_ipv4_cidr_block  = local.vars.locals.cluster.master_ipv4_cidr_block
  release_channel         = local.vars.locals.cluster.release_channel
  cluster_ipv4_cidr_block = local.vars.locals.cluster.cluster_ipv4_cidr_block
  services_ipv4_cidr_block= local.vars.locals.cluster.services_ipv4_cidr_block
  auth_network            = local.configs_content
  maintenance_start_time  = local.vars.locals.cluster.maintenance_start_time
  maintenance_end_time    = local.vars.locals.cluster.maintenance_end_time
  maintenance_recurrence  = local.vars.locals.cluster.maintenance_recurrence
}
