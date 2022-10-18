/*variable "VPCProperties" {
  type = map(string)
  

}*/
variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)

  default     = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "subnetscount" {
  type = any
  default =2
}
variable "VPCName" {
  type = string
  default = "WebServer'sVPC"
}

variable "Environment" {
  type = string
  default = "Development"
  
}

variable "region" {
  type =string
}
variable "azs" {
  type = list(string)
  default = ["a","b"]
}