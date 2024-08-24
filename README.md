# DigitalOcean Kubernetes Service (DOKS) Cluster Module
Manages the deployment of DOKS infrastructure;

- [x] Creates the primary DOKS cluster
- [x] Creates an internal VPC for the primary DOKS cluster
- [x] Creates a fail-over DOKS cluster & VPCs
- [ ] Applies DNS Record updates for failover

The idea with this cluster module is to have two node pools;
- The "primary" pool, containing constantly-running nodes
- The "secondary" pool, containing scalable nodes

# Variables
- `cluster_name` - Name of the kubernetes cluster to create
- `region` - Primary region to create the kubernetes cluster within
- `backup_region` - List of regions to create fail-over clusters within
- `kubernetes_version` - Version of Kubernetes to run
- `dedicated_node_count` - Amount of dedicated nodes to hold (in the primary pool)
- `dedicated_node_size` - Instance template size to use for nodes within the primary pool
- `tags` - List of tags to apply to all resources created from this module
- `vpc_order` - Number inserted within the IP Address `10.{vpc_order}.0.0/24`.
  - For now, this IP schema is hardcoded.