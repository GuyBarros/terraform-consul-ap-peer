
# variable cluster_names{
#   # default = ["cluster1","cluster2","cluster3","cluster4","cluster5","cluster6"]
#   default = "cluster6"
# }

///// TODO make this a "for each"
////////
module "cluster_1" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source = "./eks_dc_setup"


   aws_region         = var.region
  cluster_name = "dominio1"
  
  
}

module "cluster_2" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source = "./eks_dc_setup"
   aws_region         = var.region
  cluster_name = "cluster2"
  cluster_version = var.cluster_version
  
}

module "cluster_3" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source = "./eks_dc_setup"
   aws_region         = var.region
  cluster_name = "hashicups_backend"
  cluster_version = var.cluster_version
}

# module "cluster_4" {
#   # I'd have to remove all the provider from the modules, not today
#   # for_each = toset(var.cluster_names)
#   source = "./eks_dc_setup"
#    aws_region         = var.region
#   cluster_name = "hashicups_frontend"
#   cluster_version = var.cluster_version
# }


# module "cluster_5" {
#   # I'd have to remove all the provider from the modules, not today
#   # for_each = toset(var.cluster_names)
#   source = "./eks_dc_setup"
#    aws_region         = var.region
#   cluster_name = "hashicups_frontend"
#   cluster_version = var.cluster_version
# }


output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name_cluster1" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_1.cluster_name
}

output "vault_access_instructions_cluster1" {
  description = "Instructions for accessing Vault with TLS"
  value       = module.cluster_1.vault_access_instructions
}

output "cluster_name_cluster2" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_2.cluster_name
}

output "vault_access_instructions_cluster2" {
  description = "Instructions for accessing Vault with TLS"
  value       = module.cluster_2.vault_access_instructions
}

output "cluster_name_cluster3" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_3.cluster_name
}

output "vault_access_instructions_cluster3" {
  description = "Instructions for accessing Vault with TLS"
  value       = module.cluster_3.vault_access_instructions
}