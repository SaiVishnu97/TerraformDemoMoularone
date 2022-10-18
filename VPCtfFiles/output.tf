output "VPCid" {
  value = aws_vpc.vpc1.id

}

output "Subnetid" {
  value = aws_subnet.subnet.*.id
}