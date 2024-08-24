locals {
  default_tags = []
  resource_tags = concat(var.tags, local.default_tags)
}

variable "vpc_order" {
  type = string
  description = "describe your variable"
  default = 10
}

variable "tags" {
  type = list(string)
  description = "tags to apply to all resources"
  default = []
}

variable "cluster_name" {
  type = string
  description = "name of the kubernetes cluster"
}

variable "region" {
  type = string
  description = "location of the primary region"
}

variable "backup_regions" {
  type = list(string)
  description = "locations of backup regions"
  default = []
}

variable "kubernetes_version" {
  type = string
  description = "kubernetes version to adopt in the cluster"
  default = "1.30.2-do.0"
}

variable "dedicated_node_count" {
  type = number
  description = "amount of persistent nodes to have in the node pool"
  default = 1
}

variable "dedicated_node_size" {
  type = string
  description = "node size to use for the dedicated fleet"
  default = "s-1vcpu-2gb-amd"
}