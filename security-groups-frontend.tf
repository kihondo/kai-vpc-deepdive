# Get the security group ID from the instance
data "aws_instance" "frontend_public_ec2_instances" {
  for_each = var.frontend_public_ec2_instances

  instance_id = module.frontend_public_ec2_instance[each.key].id
}

# Add SSH ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_public_ssh" {
  for_each = var.frontend_public_ec2_instances

  security_group_id = tolist(data.aws_instance.frontend_public_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "SSH access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "ssh-ingress-${each.key}"
  }
}

# Add HTTP ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_public_http" {
  for_each = var.frontend_public_ec2_instances

  security_group_id = tolist(data.aws_instance.frontend_public_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "HTTP access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  tags = {
    Name = "http-ingress-${each.key}"
  }
}

# Add HTTPS ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_public_https" {
  for_each = var.frontend_public_ec2_instances

  security_group_id = tolist(data.aws_instance.frontend_public_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "HTTPS access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    Name = "https-ingress-${each.key}"
  }
}

data "aws_instance" "frontend_private_ec2_instances" {
  for_each = var.frontend_private_ec2_instances

  instance_id = module.frontend_private_ec2_instance[each.key].id
}

# Add SSH ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_private_ssh" {
  for_each = var.frontend_private_ec2_instances

  security_group_id = tolist(data.aws_instance.frontend_private_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "SSH access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "ssh-ingress-${each.key}"
  }
}