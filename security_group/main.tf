# security-group/main.tf

resource "aws_security_group" "Myecs_security_group" {
  name_prefix = "Myecs-"
}

resource "aws_security_group_rule" "ecs_http_ingress" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Myecs_security_group.id

}

resource "aws_security_group_rule" "ecs_http_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Myecs_security_group.id

}


output "security_group_id" {
  value = aws_security_group.Myecs_security_group.id
}
