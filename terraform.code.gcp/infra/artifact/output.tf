output "artifact_repository_details" {
  value = { for repo_id, repo in google_artifact_registry_repository.dcs_repo : repo_id => {
    name = repo.repository_id
  }}
  description = "The names and URLs of the created artifact repositories."
}
