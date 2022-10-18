/*variable "AWScreds" {
  type = map(any)
  
}*/
variable "region" {
  type = string
  default = "us-east-2"
}
variable "AZ" {
  type = list(string)
  default = [ "us-east-2a","us-east-2b" ]
}
variable "webservers" {
  type=set(string)
  default = [ "TerraformWebServer1","TerraformWebServer2" ]
}
variable "instance_type" {
  type = string
  default = "t2.small"
}
variable "image_id" {
  type = string
  default = "ami-0d5bf08bc8017c83b"
}


variable "userData" {
  type=string
}