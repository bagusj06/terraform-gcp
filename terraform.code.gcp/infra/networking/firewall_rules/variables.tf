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

variable "network_self_link" {
  description = "The self link of the network where firewall rules will be applied"
  type        = string
}

variable "allow_firewall_rules" {
  type    = list(object({
    name      = string
    source_ip = list(string)
    protocol  = string
    port      = string
    rule      = string
  }))
  default = []
}

variable "deny_firewall_rules" {
  type    = list(object({
    name      = string
    source_ip = list(string)
    protocol  = string
    port      = string
    rule      = string
  }))
  default = []
}