locals {
  vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "google" {
      project = "${local.vars.locals.gcp_project_id}"
      region  = "${local.vars.locals.region}"
    }
  EOF
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${local.vars.locals.remote_state_bucket}"
    prefix         = "tf-platform/${path_relative_to_include()}"
    location       = "asia-southeast2"
  }
}
# Force Terraform to keep trying to acquire a lock for up to 20 minutes if someone else already has the lock
terraform {
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=20m"]
  }

  after_hook "success" {
    commands = ["apply"]
    execute  = ["cmd", "/c", "echo Changes have been applied successfully"]
    run_on_error = false
  }
}

inputs = merge(
  local.vars.locals,
)