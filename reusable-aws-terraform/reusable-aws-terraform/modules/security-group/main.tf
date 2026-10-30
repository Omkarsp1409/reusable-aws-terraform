
resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.security_group_name
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  count = length(var.ingress_rules)

  security_group_id = aws_security_group.this.id
  description       = var.ingress_rules[count.index].description
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  ip_protocol       = var.ingress_rules[count.index].protocol
  cidr_ipv4         = length(var.ingress_rules[count.index].cidr_blocks) == 1 ? var.ingress_rules[count.index].cidr_blocks[0] : null
}

resource "aws_vpc_security_group_egress_rule" "this" {
  count = length(var.egress_rules)

  security_group_id = aws_security_group.this.id
  description       = var.egress_rules[count.index].description
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  ip_protocol       = var.egress_rules[count.index].protocol
  cidr_ipv4         = length(var.egress_rules[count.index].cidr_blocks) == 1 ? var.egress_rules[count.index].cidr_blocks[0] : null
}
