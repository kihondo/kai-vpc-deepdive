# VPC Peering using Terraform
* This repo contains Terraform files to provision VPC Peering on AWS.

### Terraform Providers used in this project
* `source  = "hashicorp/aws"`
    * `version = "~> 6.7.0"`

### Terraform Modules used in this project
* `source  = "terraform-aws-modules/vpc/aws"`
    * `version = "6.0.1"` # Jun 30, 2025
 
### Challenges
* To allow icmp for all public instances from 0.0.0.0/0
* To allow icmp for all private instances from 0.0.0.0/0
* anything you can improve the security groups configuration
* created private ec2-instances in private subnets
