variable "project_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "disk_size_gb" {
  type = string
}

variable "disk_type" {
  type = string
}

variable "min_node_count" {
  type = string
}

variable "max_node_count" {
  type = string
}

variable "deletion_protection" {
  type = string
}

variable "master_ipv4_cidr_block" {
  type = string
}

variable "release_channel" {
  type = string
}

variable "cluster_ipv4_cidr_block" {
  type = string
}

variable "services_ipv4_cidr_block" {
  type = string
}
variable "auth_network" {
  type    = list(object({
    name  = string
    ip    = string
  }))
  description = "List of auth network"
}

variable "maintenance_start_time" {
  type = string
}

variable "maintenance_end_time" {
  type = string
}

variable "maintenance_recurrence" {
  type = string
}