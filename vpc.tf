resource "digitalocean_vpc" "primary" {
  name = "${var.cluster_name}-${var.region}-vpc"
  region = var.region
  description = "VPC Network for the ${var.cluster_name} cluster"
  ip_range = "10.${var.vpc_order}.0.0/24"
}

resource "digitalocean_vpc" "secondary" {
  count = length(var.backup_regions)
  name = "${var.cluster_name}-${var.backup_regions[count.index]}-vpc"
  region = var.backup_regions[count.index]
  description = "VPC Network for the ${var.cluster_name} cluster"
  ip_range = "10.${var.vpc_order}.${count.index + 1}.0/24"
}