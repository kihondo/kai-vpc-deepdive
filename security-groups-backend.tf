# Get the security group ID from the instance
data "aws_instance" "backend_public_ec2_instances" {
  for_each = var.backend_public_ec2_instances

  instance_id = module.backend_public_ec2_instance[each.key].id
}

# Add SSH ingress rules
resource "aws_vpc_security_group_ingress_rule" "backend_public_ssh" {
  for_each = var.backend_public_ec2_instances

  security_group_id = tolist(data.aws_instance.backend_public_ec2_instances[each.key].vpc_security_group_ids)[0]
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
resource "aws_vpc_security_group_ingress_rule" "backend_public_http" {
  for_each = var.backend_public_ec2_instances

  security_group_id = tolist(data.aws_instance.backend_public_ec2_instances[each.key].vpc_security_group_ids)[0]
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
resource "aws_vpc_security_group_ingress_rule" "backend_public_https" {
  for_each = var.backend_public_ec2_instances

  security_group_id = tolist(data.aws_instance.backend_public_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "HTTPS access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    Name = "https-ingress-${each.key}"
  }
}

# Allow ICMP (all types and codes) from anywhere for ping and traceroute
resource "aws_vpc_security_group_ingress_rule" "backend_public_icmp" {
  for_each = var.backend_public_ec2_instances

  security_group_id = tolist(data.aws_instance.backend_public_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "Allow ICMP (ping and traceroute) from anywhere"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "icmp-ingress-all-${each.key}"
  }
}

data "aws_instance" "backend_private_ec2_instances" {
  for_each = var.backend_private_ec2_instances

  instance_id = module.backend_private_ec2_instance[each.key].id
}

# Add SSH ingress rules
resource "aws_vpc_security_group_ingress_rule" "backend_private_ssh" {
  for_each = var.backend_private_ec2_instances

  security_group_id = tolist(data.aws_instance.backend_private_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "SSH access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "ssh-ingress-${each.key}"
  }
}

# Allow ICMP (all types and codes) from anywhere for ping and traceroute
resource "aws_vpc_security_group_ingress_rule" "backend_private_icmp" {
  for_each = var.backend_private_ec2_instances

  security_group_id = tolist(data.aws_instance.backend_private_ec2_instances[each.key].vpc_security_group_ids)[0]
  description       = "Allow ICMP (ping and traceroute) from anywhere"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "icmp-ingress-all-${each.key}"
  }
}