
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

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

################################################################################
# VPC
################################################################################

variable "name" {
  description = "Tutorial name"
  type        = string
  default     = "learn-consul"
}

variable "vpc_region" {
  type        = string
  description = "The AWS region to create resources in"
  default     = "us-west-2"
}

################################################################################
# Consul
################################################################################

variable "consul_version" {
  type        = string
  description = "The Consul version"
  default     = "1.22.2"
}

variable "consul_chart_version" {
  type        = string
  description = "The Consul Helm chart version to use"
  default     = "1.9.1"
}

variable "datacenter" {
  type        = string
  description = "The name of the Consul datacenter that client agents should register as"
  default     = "dc1"
}

################################################################################
# Other
################################################################################

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
  name = "${var.name}-${random_string.suffix.result}"
}