variable "vpc_cidr_block" {
  default     = "192.168.0.0/24"
  description = "CIDR block for vpc"
}

variable "vpc_subnet_blocks" {
  type        = map
  description = "CIRD blocks for subnets in vpc"
}

variable "azs" {
  type        = list
  default     = ["eu-west-2a", "eu-west-2b"]
  description = "list of availability zones"
}

variable "ami" {
  default     = "ami-f976839e"
  description = "default ami for our instances"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "our default instance type"
}

variable "db-instance-class" {
  default     = "db.t3.micro"
  description = "our default db instance class"
}

variable "home_ips" {
  default = []
}

variable "user" {
  default = []
}

variable "pass" {
  default = []
}

variable "create_database" {
  default     = false
  description = "create database if set to true"
}

variable "create_nat_gw" {
  default     = false
  description = "create nat gateway if set to true"
}