variable "cluster5_name" {
  description = "Name of the EKS cluster 4"
  type        = string
  default     = "backend"
}

module "cluster_5" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source          = "./modules/hashicups_env"
  aws_region      = var.region
  cluster_name    = var.cluster5_name
  cluster_version = var.cluster_version
}


output "cluster_name_cluster5" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_5.cluster_name
}

output "eks_access_instructions_cluster5" {
  description = "Instructions for accessing EKS"
  value       = module.cluster_5.eks_access_instructions
}
