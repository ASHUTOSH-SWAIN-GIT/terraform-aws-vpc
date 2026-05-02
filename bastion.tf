################################################################################
# Bastion Host Security Group
################################################################################

resource "aws_security_group" "bastion" {
  name        = "${var.name}-bastion"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.this[0].id

  tags = merge(local.tags, {
    Name = "${var.name}-bastion"
  })
}

resource "aws_security_group_rule" "bastion_ssh_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow SSH from anywhere"
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
  security_group_id = aws_security_group.bastion.id
}
