
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
    public_subnets =  ["10.0.1.0/24","10.0.2.0/24"]
    cidr_block = "10.0.0.0/16"
}
module "ASGForWebServers" {

    source = "./ASGtffiles"
    userData = var.userData
    VPCid = module.VPCForWebServers.VPCid
    Subnetid = module.VPCForWebServers.Subnetid
    lb_target_group_arn = module.ALBForWebServers.ALBTGArn

    image_id = var.image_id
    instance_type = var.instance_type
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
