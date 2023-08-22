variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "folder_id" {
  type        = string
  description = "The ID of a folder to host this project"
  default     = ""
}

variable "billing_account" {
  type        = string
  description = "The ID of the billing account to associate this project with. Default is Formlabs SADA"
  default     = ""
}

variable "activate_apis" {
  type        = list(string)
  description = "The list of apis to activate within the project"
  default     = []
}

variable "activate_api_identities" {
  type = list(object({
    api   = string
    roles = list(string)
  }))
  description = "The list of service identitie to force-create for the project"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "The list of labels that assign with the project"
  default     = {}
}
