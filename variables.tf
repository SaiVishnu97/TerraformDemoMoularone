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



variable "userData" {
  type=string
}