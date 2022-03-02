#provider
provider "aws" {
  region = "us-east-2"
}

#Resource - VPC
resource "aws_vpc" "ibm" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "IBM-VPC"
  }
}

# Resource - internet gateway
resource "aws_internet_gateway" "ibm-igw" {
  vpc_id = aws_vpc.ibm.id

  tags = {
    Name = "IBM-IGW"
  }
}

# Resource - IBM PUBLIC SUBNET
resource "aws_subnet" "ibm-pub-sn" {
  vpc_id                  = aws_vpc.ibm.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "IBM-PUB-SUBNET"
  }
}

# Resource - IBM PUBLIC SUBENT ZONE A	
resource "aws_subnet" "ibm-pub-sn-a" {
  vpc_id                  = aws_vpc.ibm.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "IBM-PUB-SUBNET-A"
  }
}

# Resource - IBM PUBLIC ROUTE TABLE
resource "aws_route_table" "ibm_pub_rt" {
  vpc_id = aws_vpc.ibm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ibm-igw.id
  }
  tags = {
    Name = "IBM-PUB-RT"
  }
}

# Resource - IBM public route table - SUBNET ASSOCIATION- B
resource "aws_route_table_association" "ibm_pub_asc_b" {
  subnet_id      = aws_subnet.ibm-pub-sn.id
  route_table_id = aws_route_table.ibm_pub_rt.id
}

# Resource - IBM public route table - SUBNET ASSOCIATION- A
resource "aws_route_table_association" "ibm_pub_asc_a" {
  subnet_id      = aws_subnet.ibm-pub-sn-a.id
  route_table_id = aws_route_table.ibm_pub_rt.id
}


#Resource - IBM Private SUBNET
resource "aws_subnet" "ibm-pvt-sn" {
  vpc_id                  = aws_vpc.ibm.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "IBM-PVT-SUBNET"
  }
}

#Resource - IBM PRIVATE SUBNET ZONE A
resource "aws_subnet" "ibm-pvt-sn-a" {
  vpc_id                  = aws_vpc.ibm.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "IBM-PVT-SUBNET-A"
  }
}


# Resource - IBM PRIVATE ROUTE TABLE
resource "aws_route_table" "ibm_pvt_rt" {
  vpc_id = aws_vpc.ibm.id

  tags = {
    Name = "IBM-PVT-RT"
  }
}


# Resource - IBM PVT ROUTE TABLE - SUBNET Association -B
resource "aws_route_table_association" "ibm_pvt_asc_b" {
  subnet_id      = aws_subnet.ibm-pvt-sn.id
  route_table_id = aws_route_table.ibm_pvt_rt.id
}

# RESOURCE - IBM PVT ROUTE TABLE - SUBNET ASSOCIATION - A

resource "aws_route_table_association" "ibm_pvt_asc_a" {

  subnet_id = aws_subnet.ibm-pvt-sn-a.id

  route_table_id = aws_route_table.ibm_pvt_rt.id
}
