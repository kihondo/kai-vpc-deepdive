frontend_vpc_name                   = "kai-frontend-vpc"
frontend_vpc_cidr                   = "10.0.0.0/16"
frontend_vpc_azs                    = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
frontend_vpc_public_subnets         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
frontend_vpc_private_subnets        = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
frontend_vpc_enable_nat_gateway     = true
frontend_vpc_single_nat_gateway     = true
frontend_vpc_one_nat_gateway_per_az = false

backend_vpc_name                   = "kai-backend-vpc"
backend_vpc_cidr                   = "192.168.0.0/16"
backend_vpc_azs                    = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
backend_vpc_public_subnets         = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
backend_vpc_private_subnets        = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24"]
backend_vpc_enable_nat_gateway     = true
backend_vpc_single_nat_gateway     = true
backend_vpc_one_nat_gateway_per_az = false

### frontend_public_ec2_instances ###
frontend_public_ec2_instances = {
  "public-machine-1" = 0
  "public-machine-2" = 1
  "public-machine-3" = 2
}

frontend_public_ec2_instance_type           = "t2.micro"
frontend_ec2_key_name                       = "ec2-singapore-ssh-keypair"
frontend_associate_public_ip_address_on_ec2 = true

### frontend_private_ec2_instances ###
frontend_private_ec2_instances = {
  "private-machine-1" = 0
  "private-machine-2" = 1
  "private-machine-3" = 2
}

frontend_private_ec2_instance_type = "t2.micro"
# frontend_ec2_key_name                    = "ec2-tokyo-ssh-keypair"
frontend_associate_public_ip_address_off_ec2 = false

### backend_public_ec2_instances ###
backend_public_ec2_instances = {
  "public-machine-1" = 0
  "public-machine-2" = 1
  "public-machine-3" = 2
}

backend_public_ec2_instance_type           = "t2.micro"
backend_ec2_key_name                       = "ec2-tokyo-ssh-keypair"
backend_associate_public_ip_address_on_ec2 = true

### backend_private_ec2_instances ###
backend_private_ec2_instances = {
  "private-machine-1" = 0
  "private-machine-2" = 1
  "private-machine-3" = 2
}

backend_private_ec2_instance_type = "t2.micro"
# backend_ec2_key_name                    = "ec2-tokyo-ssh-keypair"
backend_associate_public_ip_address_off_ec2 = false