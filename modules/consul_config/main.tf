resource "consul_certificate_authority" "connect" {
  connect_provider = "vault"

  config_json = jsonencode({
    Address             = var.vault_address,
    Namespace           = var.vault_namespace,
    Token               = var.vault_token,
    RootPKIPath         = var.pki_root_path,
    IntermediatePKIPath = var.pki_int_path,
    LeafCertTTL         = var.leaf_cert_ttl
    RotationPeriod      = var.rotation_period,
    IntermediateCertTTL = var.intermediate_cert_ttl,
    PrivateKeyType      = var.private_key_type,
    PrivateKeyBits      = var.private_key_bits
  })
}