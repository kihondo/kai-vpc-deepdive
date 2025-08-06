frontend_vpc_name = "kai-frontend-vpc"
frontend_vpc_cidr = "10.0.0.0/16"
frontend_vpc_azs = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
frontend_vpc_public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
frontend_vpc_private_subnets = ["10.0.100.0/24", "10.0.101.0/24","10.0.102.0/24"]
frontend_vpc_enable_nat_gateway = true
frontend_vpc_single_nat_gateway = false
frontend_vpc_one_nat_gateway_per_az = false

backend_vpc_name = "kai-backend-vpc"
backend_vpc_cidr = "192.168.0.0/16"
backend_vpc_azs = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
backend_vpc_public_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
backend_vpc_private_subnets = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24"]
backend_vpc_enable_nat_gateway = true
backend_vpc_single_nat_gateway = false
backend_vpc_one_nat_gateway_per_az = false