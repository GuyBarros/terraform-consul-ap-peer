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

variable "vault_token" {
  description = "Vault server namespace (if applicable)"
  type        = string
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

variable "leaf_cert_ttl" {
  description = "TTL for leaf certificates"
  type        = string
  default     = "24h"
}

variable "intermediate_cert_ttl" {
  description = "TTL for intermediate certificates"
  type        = string
  default     = "8760h" # 1 year
}

variable "rotation_period" {
  description = "Rotation period for intermediate CA"
  type        = string
  default     = "43800h" # 5 years
}

variable "private_key_type" {
  description = "Private key type for certificates"
  type        = string
  default     = "rsa"
}

variable "private_key_bits" {
  description = "Private key bits for certificates"
  type        = number
  default     = 2048
}

