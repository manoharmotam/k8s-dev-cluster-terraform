data "aws_ssm_parameter" "cluster_name" {
  name = "/${var.project}/${var.environment}/eks_cluster_name"
}

data "aws_ssm_parameter" "bastion_role_arn" {
  name = "/${var.project}/${var.environment}/bastion_iam_role_arn"
}