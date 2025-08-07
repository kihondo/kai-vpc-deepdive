
################################
# ec2-private-instances-frontend-vpc
################################

# Private DNS and Private IP
output "frontend_private_ec2_instance_private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  #   value = values(module.frontend_private_ec2_instance)[*].private_dns
  value = { for k, v in module.frontend_private_ec2_instance : k => v.private_dns }
}

output "frontend_private_ec2_private_ip" {
  description = "The private IP address assigned to the instance"
  #   value = values(module.frontend_private_ec2_instance)[*].private_ip
  value = { for k, v in module.frontend_private_ec2_instance : k => v.private_ip }
}

# Public DNS and Public IP
output "frontend_private_ec2_instance_public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  #   value = values(module.frontend_private_ec2_instance)[*].public_dns
  value = { for k, v in module.frontend_private_ec2_instance : k => v.public_dns }
}

output "frontend_private_ec2_public_ip" {
  description = "The public IP address assigned to the instance, if applicable."
  #   value       = values(module.frontend_private_ec2_instance)[*].public_ip
  value = { for k, v in module.frontend_private_ec2_instance : k => v.public_ip }
}

/* value       = values(module.frontend_private_ec2_instance)[*].public_ip
frontend_ec2_public_ip = [
  "18.183.213.180",
  "35.78.63.154",
  "43.206.131.106",
]
*/
################################
# ec2-private-instances-backend-vpc
################################
# Private DNS and Private IP
output "backend_private_ec2_instance_private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  #   value = values(module.backend_public_ec2_instance)[*].private_dns
  value = { for k, v in module.backend_private_ec2_instance : k => v.private_dns }
}

output "backend_private_ec2_private_ip" {
  description = "The private IP address assigned to the instance"
  #   value = values(module.backend_public_ec2_instance)[*].private_ip
  value = { for k, v in module.backend_private_ec2_instance : k => v.private_ip }
}

# Public DNS and Public IP
output "backend_private_ec2_instance_public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  #   value = values(module.backend_public_ec2_instance)[*].public_dns
  value = { for k, v in module.backend_private_ec2_instance : k => v.public_dns }
}

output "backend_private_ec2_public_ip" {
  description = "The public IP address assigned to the instance, if applicable."
  #   value       = values(module.backend_public_ec2_instance)[*].public_ip
  value = { for k, v in module.backend_private_ec2_instance : k => v.public_ip }
}