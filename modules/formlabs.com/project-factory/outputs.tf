output "gcp_project_id" {
  value       = module.gcp_project.project_id
  description = "The ID of the GCP project."
}

output "gcp_project_name" {
  value       = module.gcp_project.project_name
  description = "The name of the GCP project."
}
