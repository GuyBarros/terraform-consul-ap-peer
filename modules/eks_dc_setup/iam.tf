

# IAM Role for EBS CSI Driver
module "ebs_csi_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"
  #source  = "terraform-aws-modules/iam/aws"
  #source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"


  role_name = "${var.cluster_name}-ebs-csi-driver"

  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
