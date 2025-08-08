module "frontend_public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  for_each = var.frontend_public_ec2_instances

  name                        = "frontend-${each.key}"
  instance_type               = var.frontend_public_ec2_instance_type
  key_name                    = var.frontend_ec2_key_name
  subnet_id                   = var.frontend_ec2_public_subnet_type == "public" ? module.aws-frontend-vpc.public_subnets[each.value] : module.aws-frontend-vpc.private_subnets[each.value]
  associate_public_ip_address = var.frontend_associate_public_ip_address_on_ec2
  monitoring                  = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}

module "frontend_private_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  for_each = var.frontend_private_ec2_instances

  name                        = "frontend-${each.key}"
  instance_type               = var.frontend_private_ec2_instance_type
  key_name                    = var.frontend_ec2_key_name
  subnet_id                   = var.frontend_ec2_private_subnet_type == "private" ? module.aws-frontend-vpc.private_subnets[each.value] : module.aws-frontend-vpc.public_subnets[each.value]
  associate_public_ip_address = var.frontend_associate_public_ip_address_off_ec2
  monitoring                  = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}
