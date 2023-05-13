
#VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "prod-vpc"
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "prod-igw"
  }
}

#adding IG to default RT
resource "aws_default_route_table" "main_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "main-prod-rt"
  }
}

#route table for RDS
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "prod-rt"
  }
}

#route table assosiation with private subnet 
resource "aws_route_table_association" "private_sub_association" {
  subnet_id      = aws_subnet.rds_sub.id
  route_table_id = aws_route_table.rt2.id
}

#route table assosiation with private subnet2 
resource "aws_route_table_association" "private_sub_association2" {
  subnet_id      = aws_subnet.rds_sub2.id
  route_table_id = aws_route_table.rt2.id
}






