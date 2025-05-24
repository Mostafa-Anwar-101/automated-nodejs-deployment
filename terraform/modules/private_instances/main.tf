resource "aws_instance" "private" {
  for_each = var.private_subnets

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  associate_public_ip_address = false

  tags = {
    Name = "${var.project_name}-${each.key}-private-instance"
  }
}

resource "aws_instance" "jenkins_slave" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets["private-1"].subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  associate_public_ip_address = false

  tags = {
    Name = "${var.project_name}-jenkins-slave"
  }
  
}
