output "service_account_emails" {
  value = { for key, sa in google_service_account.azure_devops_service_account : key => sa.email }
  description = "The email addresses of the created service accounts."
}

output "service_account_roles" {
  value = {
    for acc_name, roles in local.service_accounts_map : acc_name => roles
  }
  description = "Roles assigned to each service account."
}
