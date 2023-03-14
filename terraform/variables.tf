
variable "region" {}
variable "environment" {}
variable "domain" {}
variable "hosted_zone_id" {}
variable "cluster_name" {}
variable "cluster_version" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_1" {
  default = "10.0.0.0/19"
}

variable "private_subnet_2" {
  default = "10.0.32.0/19"
}

variable "private_subnet_3" {
  default = "10.0.128.0/19"
}

variable "public_subnet_1" {
  default = "10.0.64.0/19"
}

variable "public_subnet_2" {
  default = "10.0.96.0/19"
}

variable "public_subnet_3" {
  default = "10.0.160.0/19"
}