# Get the security group ID from the instance
# data "aws_instance" "frontend_public_ec2_instances" {
#   provider = aws.singapore
#   for_each = var.frontend_public_ec2_instances

#   instance_id = module.frontend_public_ec2_instance[each.key].id
# }

# Security Group allowing SSH, ping (ICMP), and traceroute (ICMP)
resource "aws_security_group" "frontend_public_ssh_ping_traceroute" {
  provider    = aws.singapore
  name        = "frontend-public-ssh-ping-traceroute"
  description = "Allow SSH, ping, and traceroute"
  vpc_id      = module.aws-frontend-vpc.vpc_id

  tags = {
    Name = "frontend-public-ssh-ping-traceroute"
  }
}

# Add SSH ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_public_ssh" {
  provider = aws.singapore
  # for_each = var.frontend_public_ec2_instances

  security_group_id = aws_security_group.frontend_public_ssh_ping_traceroute.id
  description       = "SSH access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "ssh-ingress"
  }
}

# Add HTTP ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_public_http" {
  provider = aws.singapore
  # for_each = var.frontend_public_ec2_instances

  security_group_id = aws_security_group.frontend_public_ssh_ping_traceroute.id
  description       = "HTTP access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  tags = {
    Name = "http-ingress"
  }
}

# Add HTTPS ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_public_https" {
  provider = aws.singapore
  # for_each = var.frontend_public_ec2_instances

  security_group_id = aws_security_group.frontend_public_ssh_ping_traceroute.id
  description       = "HTTPS access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    Name = "https-ingress"
  }
}

# Allow ICMP (all types and codes) from anywhere for ping and traceroute
resource "aws_vpc_security_group_ingress_rule" "frontend_public_icmp" {
  provider = aws.singapore

  security_group_id = aws_security_group.frontend_public_ssh_ping_traceroute.id
  description       = "Allow ICMP (ping and traceroute) from anywhere"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "icmp-ingress-all"
  }
}



#######################################################
# Private EC2 Instances Security Group Configuration
#######################################################

# Security Group allowing SSH, ping (ICMP), and traceroute (ICMP)
resource "aws_security_group" "frontend_private_ssh_ping_traceroute" {
  provider    = aws.singapore
  name        = "frontend-private-ssh-ping-traceroute"
  description = "Allow SSH, ping, and traceroute"
  vpc_id      = module.aws-frontend-vpc.vpc_id

  tags = {
    Name = "frontend-private-ssh-ping-traceroute"
  }
}

# Add SSH ingress rules
resource "aws_vpc_security_group_ingress_rule" "frontend_private_ssh" {
  provider = aws.singapore
  # for_each = var.frontend_private_ec2_instances

  security_group_id = aws_security_group.frontend_private_ssh_ping_traceroute.id
  description       = "SSH access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "ssh-ingress"
  }
}

# Allow ICMP (all types and codes) from anywhere for ping and traceroute
resource "aws_vpc_security_group_ingress_rule" "frontend_private_icmp" {
  provider = aws.singapore

  security_group_id = aws_security_group.frontend_private_ssh_ping_traceroute.id
  description       = "Allow ICMP (ping and traceroute) from anywhere"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "icmp-ingress-all"
  }
}