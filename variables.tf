
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

############################

variable "vault_address" {
  description = "Vault server address"
  type        = string
  default     = "http://localhost:8200"
}

variable "vault_namespace" {
  description = "Vault server namespace (if applicable)"
  type        = string
  default     = "root"
}

variable "pki_root_path" {
  description = "Path for root PKI engine"
  type        = string
  default     = "pki_root"
}

variable "pki_int_path" {
  description = "Path for intermediate PKI engine"
  type        = string
  default     = "pki_int"
}

variable "consul_domain" {
  description = "Consul domain"
  type        = string
  default     = "consul"
}

variable "consul_datacenter" {
  description = "Consul datacenter name"
  type        = string
  default     = "dc1"
}