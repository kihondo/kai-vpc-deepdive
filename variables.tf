################################
# aws-frontend-vpc
################################
variable "frontend_vpc_name" {
  description = "Name to be used on all the resources as identifier for frontend-vpc"
  type        = string
  default     = ""
}

variable "frontend_vpc_cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "10.0.0.0/16"
}

variable "frontend_vpc_azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "frontend_vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "frontend_vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "frontend_vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "frontend_vpc_single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "frontend_vpc_one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`"
  type        = bool
  default     = false
}



################################
# aws-backend-vpc
################################
variable "backend_vpc_name" {
  description = "Name to be used on all the resources as identifier for backend-vpc"
  type        = string
  default     = ""
}

variable "backend_vpc_cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "192.168.0.0/16"
}

variable "backend_vpc_azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "backend_vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "backend_vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "backend_vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "backend_vpc_single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "backend_vpc_one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`"
  type        = bool
  default     = false
}


################################
# ec2-instances-frontend-vpc
################################
variable "frontend_public_ec2_instances" {
  description = "Map of EC2 instances to create in the frontend VPC, where the key is the instance name and the value is the index of the public subnet to use"
  type        = map(number)
  default     = {}
}

variable "frontend_private_ec2_instances" {
  description = "Map of EC2 instances to create in the frontend VPC, where the key is the instance name and the value is the index of the public subnet to use"
  type        = map(number)
  default     = {}
}

variable "frontend_public_ec2_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "frontend_private_ec2_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "frontend_ec2_public_subnet_type" {
  description = "Type of subnets to use for EC2 instances"
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.frontend_ec2_public_subnet_type)
    error_message = "Subnet type must be either 'public' or 'private'."
  }
}

variable "frontend_ec2_private_subnet_type" {
  description = "Type of subnets to use for EC2 instances"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["public", "private"], var.frontend_ec2_private_subnet_type)
    error_message = "Subnet type must be either 'public' or 'private'."
  }
}

variable "frontend_ec2_key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "frontend_associate_public_ip_address_on_ec2" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = null
}

variable "frontend_associate_public_ip_address_off_ec2" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = null
}

################################
# ec2-instances-backend-vpc
################################
variable "backend_public_ec2_instances" {
  description = "Map of EC2 instances to create in the backend VPC, where the key is the instance name and the value is the index of the public subnet to use"
  type        = map(number)
  default     = {}
}

variable "backend_private_ec2_instances" {
  description = "Map of EC2 instances to create in the backend VPC, where the key is the instance name and the value is the index of the public subnet to use"
  type        = map(number)
  default     = {}
}

variable "backend_public_ec2_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "backend_private_ec2_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "backend_ec2_public_subnet_type" {
  description = "Type of subnets to use for EC2 instances"
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.backend_ec2_public_subnet_type)
    error_message = "Subnet type must be either 'public' or 'private'."
  }
}

variable "backend_ec2_private_subnet_type" {
  description = "Type of subnets to use for EC2 instances"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["public", "private"], var.backend_ec2_private_subnet_type)
    error_message = "Subnet type must be either 'public' or 'private'."
  }
}

variable "backend_ec2_key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "backend_associate_public_ip_address_on_ec2" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = null
}

variable "backend_associate_public_ip_address_off_ec2" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = null
}