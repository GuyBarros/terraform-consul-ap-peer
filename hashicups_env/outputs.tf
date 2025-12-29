
# Outputs
# output "cluster_endpoint" {
#   description = "Endpoint for EKS control plane"
#   value       = module.eks.cluster_endpoint
# }

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

################################################################################
# Outputs
################################################################################

output "vpc" {
  value = {
    vpc_id         = module.vpc.vpc_id
    vpc_cidr_block = module.vpc.vpc_cidr_block
  }
}

# output "cluster_security_group_id" {
#   description = "Security group ID attached to the EKS cluster"
#   value       = module.eks.cluster_security_group_id
# }

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

# output "configure_kubectl" {
#   description = "Configure kubectl"
#   value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}"
# }

# output "vault_kms_key_id" {
#   description = "KMS Key ID for Vault auto-unseal"
#   value       = aws_kms_key.vault.id
# }

# output "vault_service_account_role_arn" {
#   description = "IAM Role ARN for Vault service account"
#   value       = module.vault_irsa.iam_role_arn
# }

# output "vault_ui_address" {
#   description = "Get Vault UI LoadBalancer address with: kubectl get svc vault-ui -n vault"
#   value       = "kubectl get svc vault-ui -n ${var.vault_namespace}"
# }

# output "vault_init_command" {
#   description = "Initialize Vault after deployment"
#   value       = "kubectl exec -n ${var.vault_namespace} vault-0 -- vault operator init"
# }

# output "vault_ca_cert" {
#   description = "Vault CA certificate for client verification"
#   value       = tls_self_signed_cert.vault_ca.cert_pem
#   sensitive   = true
# }

output "vault_access_instructions" {
  description = "Instructions for accessing Vault with TLS"
  value       = <<-EOT
    1. Add the Vault Kubernetes cluster to your kubeconfig:
       aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}


  EOT
}