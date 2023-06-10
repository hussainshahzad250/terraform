resource "aws_vpc_peering_connection" "foo" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = "198.162.0.0/16"
  vpc_id        = "172.31.0.0/16"
}
