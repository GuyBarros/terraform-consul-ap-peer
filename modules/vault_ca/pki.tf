resource "vault_mount" "pki_root" {
  path                      = var.pki_root_path
  type                      = "pki"
  description               = "Root CA for Consul"
  default_lease_ttl_seconds = 315360000 # 10 years
  max_lease_ttl_seconds     = 315360000
}

# Generate root CA certificate
resource "vault_pki_secret_backend_root_cert" "root" {
  backend              = vault_mount.pki_root.path
  type                 = "internal"
  common_name          = "Consul Root CA"
  ttl                  = "315360000"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
  ou                   = "Consul"
  organization         = "HashiCorp"
}

# Configure CA and CRL URLs for root
resource "vault_pki_secret_backend_config_urls" "root_config" {
  backend                 = vault_mount.pki_root.path
  issuing_certificates    = ["${var.vault_address}/v1/${var.vault_namespace}/${var.pki_root_path}/ca"]
  crl_distribution_points = ["${var.vault_address}/v1/${var.vault_namespace}/${var.pki_root_path}/crl"]
}

# Enable PKI secrets engine for intermediate CA
resource "vault_mount" "pki_int" {
  path                      = var.pki_int_path
  type                      = "pki"
  description               = "Intermediate CA for Consul"
  default_lease_ttl_seconds = 31536000  # 1 year
  max_lease_ttl_seconds     = 157680000 # 5 years
}

# Generate intermediate CSR
resource "vault_pki_secret_backend_intermediate_cert_request" "intermediate" {
  backend      = vault_mount.pki_int.path
  type         = "internal"
  common_name  = "Consul Intermediate CA"
  key_type     = "rsa"
  key_bits     = 4096
  ou           = "Consul"
  organization = "HashiCorp"
}

# Sign intermediate certificate with root CA
resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate" {
  backend              = vault_mount.pki_root.path
  csr                  = vault_pki_secret_backend_intermediate_cert_request.intermediate.csr
  common_name          = "Consul Intermediate CA"
  ttl                  = "157680000"
  exclude_cn_from_sans = true
  ou                   = "Consul"
  organization         = "HashiCorp"
}

# Import signed intermediate certificate
resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  backend     = vault_mount.pki_int.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.intermediate.certificate
}

# Configure CA and CRL URLs for intermediate
resource "vault_pki_secret_backend_config_urls" "int_config" {
  backend                 = vault_mount.pki_int.path
  issuing_certificates    = ["${var.vault_address}/v1/${var.vault_namespace}/${var.pki_int_path}/ca"]
  crl_distribution_points = ["${var.vault_address}/v1/${var.vault_namespace}/${var.pki_int_path}/crl"]
}


# Create role for Consul server certificates
resource "vault_pki_secret_backend_role" "consul_server" {
  backend            = vault_mount.pki_int.path
  name               = "consul-server"
  ttl                = 86400   # 24 hours
  max_ttl            = 2592000 # 30 days
  allow_ip_sans      = true
  key_type           = "rsa"
  key_bits           = 2048
  allowed_domains    = ["server.${var.consul_datacenter}.${var.consul_domain}"]
  allow_subdomains   = false
  allow_bare_domains = true
  allow_localhost    = true
  server_flag        = true
  client_flag        = false
  generate_lease     = true
}

# Create role for Consul client certificates
resource "vault_pki_secret_backend_role" "consul_client" {
  backend            = vault_mount.pki_int.path
  name               = "consul-client"
  ttl                = 86400
  max_ttl            = 2592000
  allow_ip_sans      = true
  key_type           = "rsa"
  key_bits           = 2048
  allowed_domains    = ["client.${var.consul_datacenter}.${var.consul_domain}"]
  allow_subdomains   = false
  allow_bare_domains = true
  allow_localhost    = true
  server_flag        = false
  client_flag        = true
  generate_lease     = true
}

# Create role for general Consul services
resource "vault_pki_secret_backend_role" "consul_service" {
  backend       = vault_mount.pki_int.path
  name          = "consul-service"
  ttl           = 86400
  max_ttl       = 2592000
  allow_ip_sans = true
  key_type      = "rsa"
  key_bits      = 2048
  allowed_domains = [
    "${var.consul_datacenter}.${var.consul_domain}",
    "*.${var.consul_datacenter}.${var.consul_domain}"
  ]
  allow_subdomains   = true
  allow_glob_domains = true
  allow_localhost    = true
  server_flag        = true
  client_flag        = true
  generate_lease     = true
}
