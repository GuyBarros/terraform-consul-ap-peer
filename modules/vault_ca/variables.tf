provider "vault" {

}

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