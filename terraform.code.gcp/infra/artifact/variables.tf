variable "project_name" {
  type = string
}

variable "location" {
  type = string
}

variable "repo_format" {
  type = string
}

variable "environment" {
  type = string
}

variable "repo_names" {
  type        = list(string)
  description = "List of repository names for creating artifact repositories"
}