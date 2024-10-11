locals {
  # Convert the input variable to a map keyed by service account name for easier referencing
    service_accounts_map = { for acc in var.service_accounts : acc.name => acc.role }
    sa_name = "azure-pipelines-publisher"
}