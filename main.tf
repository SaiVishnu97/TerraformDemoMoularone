
resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "Webserverskey"
  public_key = trimspace(tls_private_key.rsa-4096-example.public_key_openssh)
  
  }

  module "VPCForWebServers" {

    source = "./VPCtfFiles"
    region = var.region

}
module "ASGForWebServers" {

    source = "./ASGtffiles"
    userData = var.userData
    VPCid = module.VPCForWebServers.VPCid
    Subnetid = module.VPCForWebServers.Subnetid
    lb_target_group_arn = module.ALBForWebServers.ALBTGArn

    image_id = "ami-0d5bf08bc8017c83b"
    instance_type = "t2.small"
    key_name = aws_key_pair.deployer.key_name
    depends_on = [
      module.VPCForWebServers,module.ALBForWebServers
    ]
}

module "ALBForWebServers" {
  
  source = "./LoadBalancerTFfiles"
  VPCid = module.VPCForWebServers.VPCid
  Subnetid = module.VPCForWebServers.Subnetid
  depends_on = [
    module.VPCForWebServers
  ]

}

resource "local_file" "private_key" {
    content  = tls_private_key.rsa-4096-example.private_key_pem
    filename = "private_key.pem"
}
