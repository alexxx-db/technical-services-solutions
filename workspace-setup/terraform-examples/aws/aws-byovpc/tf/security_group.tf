<<<<<<< HEAD
resource "aws_vpc_security_group_egress_rule" "default_sg_egress_ports" {
  for_each          = var.vpc_id == "" ? { for port in var.sg_egress_ports : tostring(port) => port } : {}
  security_group_id = module.vpc[0].default_security_group_id
  from_port         = each.value
  to_port           = each.value
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow outbound TCP traffic on port ${each.value}"
}

resource "aws_vpc_security_group_egress_rule" "default_sg_internal_tcp_egress" {
  count                        = var.vpc_id == "" ? 1 : 0
  security_group_id            = module.vpc[0].default_security_group_id
  referenced_security_group_id = module.vpc[0].default_security_group_id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
  description                  = "Allow all internal TCP egress traffic"
}

resource "aws_vpc_security_group_egress_rule" "default_sg_internal_udp_egress" {
  count                        = var.vpc_id == "" ? 1 : 0
  security_group_id            = module.vpc[0].default_security_group_id
  referenced_security_group_id = module.vpc[0].default_security_group_id
  ip_protocol                  = "udp"
  from_port                    = 0
  to_port                      = 65535
  description                  = "Allow all internal UDP egress traffic"
}

resource "aws_vpc_security_group_ingress_rule" "default_sg_self_ingress" {
  count                        = var.vpc_id == "" ? 1 : 0
  security_group_id            = module.vpc[0].default_security_group_id
  referenced_security_group_id = module.vpc[0].default_security_group_id
  ip_protocol                  = "-1"
  description                  = "Allow all traffic from self"
}
=======
resource "aws_security_group" "databricks" {
  count       = length(var.security_group_ids) == 0 ? 1 : 0
  name        = var.new_security_group_name != "" ? var.new_security_group_name : "${var.resource_prefix}-databricks-sg"
  description = "Dedicated security group for Databricks workspace"
  vpc_id      = var.vpc_id == "" ? module.vpc[0].vpc_id : var.vpc_id

  dynamic "egress" {
    for_each = var.sg_egress_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow outbound TCP traffic on port ${egress.value}"
    }
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
    description = "Allow all internal TCP egress traffic"
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    self        = true
    description = "Allow all internal UDP egress traffic"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow all traffic from self"
  }

  tags = merge(
    var.tags,
    {
      Project = var.resource_prefix
    }
  )
}
>>>>>>> 5ae32d78b2c0b591a2deddda261fcc5354acd02c
