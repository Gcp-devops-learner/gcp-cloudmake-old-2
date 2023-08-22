variable "repository_id" {
  type        = string
  description = "ID of the repository"
}

variable "project_id" {
  type        = string
  description = "The ID of a project to host this repository"
}

variable "description" {
  type        = string
  description = "Description"
  default     = "Artifact Repository"
}

variable "region" {
  type        = string
  description = "The region to host the artifact repo"
  default     = "us-east1"
}

variable "list_of_accounts_artifact_admin" {
  description = "A mapping of users or groups to be assigned as service accounts for artifact repo, having admin access to the artifact repo"
  type        = list(string)
  default     = []
}

variable "list_of_accounts_artifact_readonly" {
  description = "A mapping of users or groups to be assigned as service accounts for artifact repo, having read only access to the artifact repo"
  type        = list(string)
  default     = []
}
