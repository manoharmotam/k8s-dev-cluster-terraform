data "aws_ssm_parameter" "mongodb" {
  name = "/${var.project}/${var.environment}/mongodb_sg_id"
}

data "aws_ssm_parameter" "redis" {
  name = "/${var.project}/${var.environment}/redis_sg_id"
}

data "aws_ssm_parameter" "mysql" {
  name = "/${var.project}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "rabbitmq" {
  name = "/${var.project}/${var.environment}/rabbitmq_sg_id"
}

data "aws_ssm_parameter" "bastion" {
  name = "/${var.project}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "eks_control_plane" {
  name = "/${var.project}/${var.environment}/eks_control_plane_sg_id"
}

data "aws_ssm_parameter" "eks_node" {
  name = "/${var.project}/${var.environment}/eks_node_sg_id"
}

data "aws_ssm_parameter" "loadBalancer" {
  name = "/${var.project}/${var.environment}/loadBalancer_sg_id"
}

data "http" "get_ip" {
  url = "https://checkip.amazonaws.com"
}