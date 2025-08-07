resource "aws_vpc_peering_connection" "frontend_vpc_requester" {
  vpc_id      = module.aws-frontend-vpc.vpc_id
  peer_vpc_id = module.aws-backend-vpc.vpc_id
  #   peer_region = "ap-northeast-1"
  auto_accept = true # (Optional) Accept the peering (both VPCs need to be in the same AWS account and region).
  /*
  peer_region - (Optional) The region of the accepter VPC of the VPC Peering Connection. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side.
  */

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Side = "Requester"
  }
}

# resource "aws_vpc_peering_connection_accepter" "backend_vpc_accepter" {
#   vpc_peering_connection_id = aws_vpc_peering_connection.frontend_vpc_requester.id
#   auto_accept               = true # (Optional) Whether or not to accept the peering request. Defaults to false.

#   tags = {
#     Side = "Accepter"
#   }
# }

# Add routes to existing route tables
resource "aws_route" "frontendvpc_to_backendvpc_private" {
  count                     = length(module.aws-frontend-vpc.private_route_table_ids)
  route_table_id            = module.aws-frontend-vpc.private_route_table_ids[count.index]
  destination_cidr_block    = module.aws-backend-vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.frontend_vpc_requester.id
}

resource "aws_route" "backendvpc_to_frontendvpc_private" {
  count                     = length(module.aws-backend-vpc.private_route_table_ids)
  route_table_id            = module.aws-backend-vpc.private_route_table_ids[count.index]
  destination_cidr_block    = module.aws-frontend-vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.frontend_vpc_requester.id
}