data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "elb-sg" {
  name        = "elb-sg"
  description = "elb-sg"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elb-sg"
  }
}

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "bastion-sg"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = ["22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group" "prod-sg" {
  name        = "prod-sg"
  description = "prod-sg"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = ["22"]
    content {
      from_port      = ingress.value
      to_port        = ingress.value
      protocol       = "tcp"
      security_groups = [aws_security_group.bastion-sg.id]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "prod-sg"
  }
}

resource "aws_security_group" "backend-sg" {
  name        = "backend-sg"
  description = "backend-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port      = 0
    to_port        = 0
    protocol       = "tcp"
    security_groups = [aws_security_group.prod-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "backend-sg"
  }
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
    type                    = "ingress"
    from_port               = 0
    to_port                 = 65535
    protocol                = "tcp"
    security_group_id       = aws_security_group.backend-sg.id
    source_security_group_id = aws_security_group.backend-sg.id
}