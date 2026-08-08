resource "aws_security_group_rule" "mongodb_bastion" {
  type                     = "ingress"
  from_port                = var.ssh
  to_port                  = var.ssh
  protocol                 = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mongodb_sg_id
}

resource "aws_security_group_rule" "redis_bastion" {
  type                     = "ingress"
  from_port                = var.ssh
  to_port                  = var.ssh
  protocol                 = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.redis_sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = var.ssh
  to_port                  = var.ssh
  protocol                 = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mysql_sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion" {
  type                     = "ingress"
  from_port                = var.ssh
  to_port                  = var.ssh
  protocol                 = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.rabbitmq_sg_id
}


resource "aws_security_group_rule" "loadBalancer_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.loadBalancer_sg_id
}

resource "aws_security_group_rule" "loadBalancer_http" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.loadBalancer_sg_id
}

resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.get_ip.response_body)}/32"]
  security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "eks_control_plane_to_eks_node" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = local.eks_control_plane_sg_id
  source_security_group_id = local.eks_node_sg_id
}

resource "aws_security_group_rule" "eks_node_to_eks_control_plane" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = local.eks_node_sg_id
  source_security_group_id = local.eks_control_plane_sg_id
}

resource "aws_security_group_rule" "eks_node_vpc" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "192.168.0.0/16" ]
  security_group_id = local.eks_node_sg_id
}

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.eks_control_plane_sg_id
}