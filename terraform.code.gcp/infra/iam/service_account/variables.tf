variable "project_id" {
  type = string
}

variable "service_accounts" {
  type = list(object({
    name = string
    role = list(string)
  }))
  description = "List of service accounts and their roles"
}
