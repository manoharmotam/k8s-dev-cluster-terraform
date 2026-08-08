module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name = "dev-cluster"
  kubernetes_version = var.eks_version

  endpoint_public_access = false
  enable_cluster_creator_admin_permissions = true

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy  = {}
    vpc-cni  = {
      before_compute = true
    }
    metrics-server = {
      before_compute= true
    }
  }

  vpc_id = local.vpc_id
  subnet_ids = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  create_node_security_group = false
  create_security_group = false

  node_security_group_id = local.eks_node_sg_id
  security_group_id = local.eks_control_plane_sg_id

  eks_managed_node_groups = {
    blue_node_groups = {
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small","t3.medium","m5.xlarge","m4.xlarge"]
      capacity_type = "SPOT"

      iam_role_additional_policies = {
      EBS = "arn:aws:iam::aws:policy/AmazonEBSCSIDriverPolicyV2"
      EFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
      }
      min_size = 2
      max_size = 2
      desired_size = 2

      metadata_options = {
        http_endpoint = "enabled"
        http_put_response_hop_limit = 2
        http_tokens = "required"
      }
    }
  }

  tags = merge(local.common_tags, {
    Name = "dev-cluster"
  })
}