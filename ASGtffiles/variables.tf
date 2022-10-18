/* ********************************************************************************************************
****************Variables need for ASG so that it can  be changed on demand*********************************
************************************************************************************************************/


variable "ASGName" {
    type = string
    default ="WebServersASG"
}

variable "userData" {
  type = string
}
variable "Subnetid" {
  type = list(string)
}
variable "image_id" {
  type = string
}
variable "lb_target_group_arn" {
  type = string
}
variable "VPCid" {
  type = string
}
variable "key_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "launchtemplate" {
    type = string
    default = "WebServerslaunchtemplate"
}
variable "CapacitiesForASG" {
    type = map(any)
    default = {
        "Desired" = 2
        "Minimum" = 2
        "Maximum" = 4
    }
}

variable "SGForASG" {
    type = set(string)
    default = [80,22]
}

variable "ASGSGName" {
  type = string
  default = "ASGsSG"
}