module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name    = local.cluster_name
  kubernetes_version = "1.34"  # you can bump this too (1.27+ recommended)

  vpc_id     = module.vpc.vpc_id

  endpoint_public_access = true
 enable_cluster_creator_admin_permissions = true
 
# EKS Addons
  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
    # aws-ebs-csi-driver = {
    #   most_recent = true
    # }
  }
  
    subnet_ids = module.vpc.private_subnets


  eks_managed_node_groups = {
    group1 = {
      name                 = "${local.cluster_name}-1"
      use_name_prefix = true
      instance_types       = ["t2.small"]
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      # optional user_data can be provided via launch_template
      min_size = 2
      max_size = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2
    }

    group2 = {
      name                 = "${local.cluster_name}-2"
      use_name_prefix = true
      instance_types       = ["t2.medium"]
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      min_size = 2
      max_size = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2
    }
  }
}

# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_id
# }
