resource "aws_eks_access_entry" "bastion" {
  cluster_name = local.cluster_name
  principal_arn = local.bastion_role_arn
  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "bastion" {
  cluster_name = local.cluster_name
  principal_arn = local.bastion_role_arn
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}