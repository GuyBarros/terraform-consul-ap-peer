
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "vault"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28"
}

variable "consul_license" {
  description = "Consul Enterprise license key"
  type        = string
  sensitive   = true
}

variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

