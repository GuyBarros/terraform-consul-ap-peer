resource "vault_token" "consul_service_mesh_ca" {
  display_name = "consul-service-mesh-ca-account"

  policies = [vault_policy.consul_pki.name, "default"]

  renewable = true
  ttl       = "24h"

  renew_min_lease = 43200
  renew_increment = 86400

  metadata = {
    "purpose" = "consul-service-mesh-ca-account"
  }
}