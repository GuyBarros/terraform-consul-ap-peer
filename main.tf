variable "instance_count" {
  type    = string
  default = "1"
}
variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

variable cluster_names{
  # default = ["cluster1","cluster2","cluster3","cluster4","cluster5","cluster6"]
  default = "cluster6"
}
////////
module "ekc_dc" {
  # I'd have to remove all the provider from the modules, not today
  # for_each = toset(var.cluster_names)
  source = "./eks_dc_setup"


  instance_count = var.instance_count
  region         = var.region
  cluster_name   = var.cluster_names
  # cluster_name   = each.key

}

output "region" {
  description = "AWS region"
  value       = module.ekc_dc.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.ekc_dc.cluster_name
}
/////////////////////////