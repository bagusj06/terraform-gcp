resource "google_artifact_registry_repository" "dcs_repo" {
  for_each = { for backend in var.repo_names : "${var.environment}-${var.project_name}-${backend}" => backend }

  location      = var.location
  repository_id = each.key
  description   = "Repository for ${each.value} docker images"
  format        = var.repo_format
}
