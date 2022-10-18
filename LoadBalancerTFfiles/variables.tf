



variable "AWSALBName" {
  
  type = string
  default = "TerraformsLoadBalancer"
}
variable "Subnetid" {
  type = list(string)
}
variable "VPCid" {
  type = string
}
variable "TargetGroup" {

 type = map(any)
  default = {
    "name" = "TGForWebServer"
    "port" = 80
    "protocol" = "HTTP"
    "target_type" = "instance"
  }
}

variable "SGForALB" {
    type = set(string)
    default = [80]
}

variable "ALBSGName" {
  type = string
  default = "ALBsSG"
}