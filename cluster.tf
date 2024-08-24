resource "digitalocean_kubernetes_cluster" "primary" {
  name = "${var.cluster_name}-${var.region}"
  region = var.region
  version = var.kubernetes_version
  vpc_uuid = digitalocean_vpc.primary.id
  auto_upgrade = false
  surge_upgrade = true
  ha = false
  registry_integration = false

  node_pool {
    name = "k8s-${var.cluster_name}-dedicated"
    size = var.dedicated_node_size
    node_count = var.dedicated_node_count
  }

  tags = local.resource_tags

  maintenance_policy {
    day = "saturday"
    start_time = "04:00"
  }

  # destroy_all_associated_resources = true
}

resource "digitalocean_kubernetes_cluster" "secondary" {
  count = length(var.backup_regions)
  name = "${var.cluster_name}-${var.backup_regions[count.index]}"
  region = var.backup_regions[count.index]
  version = var.kubernetes_version
  vpc_uuid = digitalocean_vpc.secondary[count.index].id
  auto_upgrade = false
  surge_upgrade = true
  ha = false
  registry_integration = false

  node_pool {
    name = "k8s-${var.cluster_name}-dedicated"
    size = var.dedicated_node_size
    node_count = var.dedicated_node_count
  }

  tags = local.resource_tags

  maintenance_policy {
    day = "saturday"
    start_time = "04:00"
  }

  # destroy_all_associated_resources = true
}

output "primary_cluster_id" {
  value = digitalocean_kubernetes_cluster.primary.id
}

output "primary_cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.primary.endpoint
}

output "primary_cluster_kubeconfig" {
  value = digitalocean_kubernetes_cluster.primary.kube_config[0]
  sensitive = true
}