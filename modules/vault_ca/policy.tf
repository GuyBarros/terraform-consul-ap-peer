
# Create policy for Consul to access PKI
resource "vault_policy" "consul_pki" {
  name = "consul-pki"

  policy = <<EOT
# Read CA certificate
path "${var.pki_int_path}/cert/ca" {
  capabilities = ["read"]
}

# Issue certificates
path "${var.pki_int_path}/issue/consul-server" {
  capabilities = ["create", "update"]
}

path "${var.pki_int_path}/issue/consul-client" {
  capabilities = ["create", "update"]
}

path "${var.pki_int_path}/issue/consul-service" {
  capabilities = ["create", "update"]
}

# Read role configuration
path "${var.pki_int_path}/roles/consul-*" {
  capabilities = ["read"]
}
EOT
}

