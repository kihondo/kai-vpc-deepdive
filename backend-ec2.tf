module "backend_public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  for_each = var.backend_public_ec2_instances

  name                        = "backend-${each.key}"
  instance_type               = var.backend_public_ec2_instance_type
  key_name                    = var.backend_ec2_key_name
  subnet_id                   = var.backend_ec2_public_subnet_type == "public" ? module.aws-backend-vpc.public_subnets[each.value] : module.aws-backend-vpc.private_subnets[each.value]
  associate_public_ip_address = var.backend_associate_public_ip_address_on_ec2
  monitoring                  = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}

module "backend_private_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  for_each = var.backend_private_ec2_instances

  name                        = "backend-${each.key}"
  instance_type               = var.backend_private_ec2_instance_type
  key_name                    = var.backend_ec2_key_name
  subnet_id                   = var.backend_ec2_private_subnet_type == "private" ? module.aws-backend-vpc.private_subnets[each.value] : module.aws-backend-vpc.public_subnets[each.value]
  associate_public_ip_address = var.backend_associate_public_ip_address_off_ec2
  monitoring                  = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}