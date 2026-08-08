locals {
  cluster_name = data.aws_ssm_parameter.cluster_name.value
  bastion_role_arn = data.aws_ssm_parameter.bastion_role_arn.value
}
