resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from admin IP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_security_group" "agent_sg" {
  name        = "agent-sg"
  description = "Security group for Jenkins agents"
  vpc_id      = var.vpc_id
  tags = {
    Name = "agent-sg"
  }
}

# Ingress Rule: SSH from bastion
resource "aws_vpc_security_group_ingress_rule" "ssh_from_bastion" {
  security_group_id            = aws_security_group.agent_sg.id
  description                  = "SSH from bastion"
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.bastion_sg.id
}

# Ingress Rule: SSH from slave
resource "aws_vpc_security_group_ingress_rule" "ssh_from_slave" {
  security_group_id            = aws_security_group.agent_sg.id
  description                  = "SSH from bastion"
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.agent_sg.id
}

# Ingress Rule: Node.js (3000) from ALB
resource "aws_vpc_security_group_ingress_rule" "nodejs_from_alb" {
  security_group_id            = aws_security_group.agent_sg.id
  description                  = "HTTP app port (80) from ALB"
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb_sg.id
}

# Egress Rule: Allow all
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.agent_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}


resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}