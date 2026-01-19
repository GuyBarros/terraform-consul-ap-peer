# Outputs
output "root_ca_path" {
  description = "Path to root CA"
  value       = vault_mount.pki_root.path
}

output "intermediate_ca_path" {
  description = "Path to intermediate CA"
  value       = vault_mount.pki_int.path
}

output "root_ca_certificate" {
  description = "Root CA certificate"
  value       = vault_pki_secret_backend_root_cert.root.certificate
  sensitive   = true
}

output "consul_server_role" {
  description = "Vault role for Consul server certificates"
  value       = vault_pki_secret_backend_role.consul_server.name
}

output "consul_client_role" {
  description = "Vault role for Consul client certificates"
  value       = vault_pki_secret_backend_role.consul_client.name
}

output "consul_service_role" {
  description = "Vault role for Consul service certificates"
  value       = vault_pki_secret_backend_role.consul_service.name
}

output "consul_pki_policy" {
  description = "Vault policy name for Consul PKI access"
  value       = vault_policy.consul_pki.name
}

output "vault_token_consul_service_mesh_ca" {
  description = "Vault token for Consul service mesh CA access"
  value       = vault_token.consul_service_mesh_ca.id
  sensitive   = true
}   