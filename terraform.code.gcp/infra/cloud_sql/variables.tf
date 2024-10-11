variable "project_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "database_version" {
  type = string
}

variable "instance_tier" {
  type = string
}

variable "network_id" {
  type = string
}

variable "auth_network" {
  type    = list(object({
    name  = string
    ip    = string
  }))
  description = "List of auth network"
}