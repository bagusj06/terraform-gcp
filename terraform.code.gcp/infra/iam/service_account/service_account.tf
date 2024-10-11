resource "google_service_account" "azure_devops_service_account" {
  for_each     = local.service_accounts_map
  account_id   = each.key
  display_name = "${each.key} Service Account"
}

resource "google_project_iam_member" "artifact_role" {
  for_each = toset(flatten([
    for acc_name, roles in local.service_accounts_map : [
      for role in roles : "${acc_name}|${role}"
    ]
  ]))

  project = var.project_id
  role    = split("|", each.value)[1]  // Extracting the role from the combined key
  member  = "serviceAccount:${google_service_account.azure_devops_service_account[split("|", each.value)[0]].email}"
}