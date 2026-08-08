locals {
  mongodb_sg_id     = data.aws_ssm_parameter.mongodb.value
  redis_sg_id       = data.aws_ssm_parameter.redis.value
  mysql_sg_id       = data.aws_ssm_parameter.mysql.value
  rabbitmq_sg_id    = data.aws_ssm_parameter.rabbitmq.value
  bastion_sg_id     = data.aws_ssm_parameter.bastion.value
  loadBalancer_sg_id = data.aws_ssm_parameter.loadBalancer.value
  eks_control_plane_sg_id = data.aws_ssm_parameter.eks_control_plane.value
  eks_node_sg_id = data.aws_ssm_parameter.eks_node.value
}   