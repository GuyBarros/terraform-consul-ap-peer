module "cluster_2" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source          = "./modules/eks_dc_setup"
  aws_region      = var.region
  cluster_name    = "frontend"
  cluster_version = var.cluster_version

}

output "cluster_name_cluster2" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_2.cluster_name
}

output "eks_access_instructions_cluster2" {
  description = "Instructions for accessing EKS cluster with TLS"
  value       = module.cluster_2.eks_access_instructions
}
