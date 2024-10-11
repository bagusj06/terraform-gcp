variable "peering_configs" {
  type = list(object({
    peer_vpc_name   : string
    peer_project_id : string
  }))
  description = "List of VPC peering configurations"
}

variable "network_self_link" {
  description = "The self link of the network where firewall rules will be applied"
  type        = string
}