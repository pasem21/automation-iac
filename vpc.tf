terraform {
  required_providers {
      aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider aws {
  region = "us-east-1" 
}
// create a vpc
resource "aws_vpc" "demo-vpc" {
  
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    name = "newvpc:demo-vpc"
  }
}

resource "aws_subnet" "pub-sub" {
  count = length(var.availability_zone)
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = element(var.cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)
  map_public_ip_on_launch = "true"
  tags = {
    name = "pub-sub:public-subnet${count.index+1}"
  }
}

resource "aws_subnet" "pri-sub" {
  count = length(var.availability_zone)
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = element(var.cidr-private-sub, count.index)
  availability_zone = element(var.availability_zone, count.index)
  map_public_ip_on_launch = "false"
  tags = {
    name = "pri-sub:private-subnet${count.index+1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    name = "igw"
  }
}

resource "aws_eip" "eip" {
  count = length(var.cidr-private-sub)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gw" {
  count = length(var.cidr-private-sub)
  depends_on = [ aws_eip.eip ]
  allocation_id = aws_eip.eip[count.index].id
  subnet_id = aws_subnet.pri-sub[count.index].id
  tags = {
    name = "nat-gw"
  }
}




























