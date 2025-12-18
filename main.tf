variable "instance_count" {
  type    = string
  default = "1"
}
variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

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


  instance_count = var.instance_count
  region         = var.region
  cluster_name   = "cluster1"
  # cluster_name   = var.cluster_names
  # cluster_name   = each.key

}

module "cluster_2" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source = "./eks_dc_setup"


  instance_count = var.instance_count
  region         = var.region
  cluster_name   = "cluster2"
  # cluster_name   = var.cluster_names
  # cluster_name   = each.key

}

# module "cluster_3" {
#   # I'd have to remove all the provider from the modules, not today
#   # for_each = toset(var.cluster_names)
#   source = "./eks_dc_setup"


#   instance_count = var.instance_count
#   region         = var.region
#   cluster_name   = "cluster3"
#   # cluster_name   = var.cluster_names
#   # cluster_name   = each.key

# }

# module "cluster_4" {
#   # I'd have to remove all the provider from the modules, not today
#   # for_each = toset(var.cluster_names)
#   source = "./eks_dc_setup"


#   instance_count = var.instance_count
#   region         = var.region
#   cluster_name   = "cluster4"
#   # cluster_name   = var.cluster_names
#   # cluster_name   = each.key

# }

# module "cluster_5" {
#   # I'd have to remove all the provider from the modules, not today
#   # for_each = toset(var.cluster_names)
#   source = "./eks_dc_setup"


#   instance_count = var.instance_count
#   region         = var.region
#   cluster_name   = "cluster5"
#   # cluster_name   = var.cluster_names
#   # cluster_name   = each.key

# }

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name_cluster1" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_1.cluster_name
}


output "cluster_name_cluster2" {
  description = "Kubernetes Cluster Name"
  value       = module.cluster_2.cluster_name
}


# output "cluster_name_cluster3" {
#   description = "Kubernetes Cluster Name"
#   value       = module.cluster_3.cluster_name
# }


# output "cluster_name_cluster4" {
#   description = "Kubernetes Cluster Name"
#   value       = module.cluster_4.cluster_name
# }


# output "cluster_name_cluster5" {
#   description = "Kubernetes Cluster Name"
#   value       = module.cluster_5.cluster_name
# }
/////////////////////////