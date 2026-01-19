
variable "cluster1_name" {
  description = "Name of the EKS cluster 4"
  type        = string
  default     = "server"
}
module "cluster_1" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source = "./modules/eks_dc_setup"

  aws_region      = var.region
  cluster_name    = var.cluster1_name
  cluster_version = var.cluster_version

}


output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name_cluster1" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_1.cluster_name
}

output "eks_access_instructions_cluster1" {
  description = "Instructions for accessing Vault with TLS"
  value       = module.cluster_1.eks_access_instructions
}

