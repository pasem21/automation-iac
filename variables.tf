variable "cidr_block" {
  description = "pub sunet cidr-block"
  type = list(string)
  default = [ "10.0.1.0/24","10.0.2.0/24" ]
}

variable "availability_zone" {
    description = "availability zones for subnets"
    type = list(string)
    default = [ "us-east-1a", "us-east-1b" ]
}

variable "cidr-private-sub" {
  description = "pri subnet cidr block"
  type = list(string)
  default = [ "10.0.3.0/24" , "10.0.4.0/24" ]
}



















