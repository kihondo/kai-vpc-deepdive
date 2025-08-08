resource "aws_vpc_peering_connection" "frontend_vpc_requester" {
  provider    = aws.singapore
  vpc_id      = module.aws-frontend-vpc.vpc_id
  peer_vpc_id = module.aws-backend-vpc.vpc_id
  peer_region = "ap-northeast-1"
  auto_accept = false # (Optional) Accept the peering (both VPCs need to be in the same AWS account and region).
  /*
  peer_region - (Optional) The region of the accepter VPC of the VPC Peering Connection. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side.
  */

  tags = {
    Side = "Requester"
  }
}

# Set requester-side options (must be done in the requester's region!)
/* in a cross-region setup:
- You can only set accepter options from the accepter region.
- You can only set requester options from the requester's region.
*/
resource "aws_vpc_peering_connection_options" "frontend_vpc_requester_options" {
  provider                  = aws.singapore
  vpc_peering_connection_id = aws_vpc_peering_connection.frontend_vpc_requester.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  depends_on = [
    aws_vpc_peering_connection.frontend_vpc_requester,
    aws_vpc_peering_connection_accepter.backend_vpc_accepter
  ]
}

resource "aws_vpc_peering_connection_accepter" "backend_vpc_accepter" {
  provider                  = aws.tokyo
  vpc_peering_connection_id = aws_vpc_peering_connection.frontend_vpc_requester.id
  auto_accept               = true # (Optional) Whether or not to accept the peering request. Defaults to false.

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Side = "Accepter"
  }
}

# Add routes to existing route tables
resource "aws_route" "frontendvpc_to_backendvpc_private" {
  provider                  = aws.singapore
  count                     = length(module.aws-frontend-vpc.private_route_table_ids)
  route_table_id            = module.aws-frontend-vpc.private_route_table_ids[count.index]
  destination_cidr_block    = module.aws-backend-vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.frontend_vpc_requester.id
}

resource "aws_route" "backendvpc_to_frontendvpc_private" {
  provider                  = aws.tokyo
  count                     = length(module.aws-backend-vpc.private_route_table_ids)
  route_table_id            = module.aws-backend-vpc.private_route_table_ids[count.index]
  destination_cidr_block    = module.aws-frontend-vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.frontend_vpc_requester.id
}